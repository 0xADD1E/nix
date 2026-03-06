{ config, lib, pkgs, inputs, hostname, ... }:
{
  imports = [ inputs.opnix.homeManagerModules.default ];
  programs.onepassword-secrets = {
    enable = lib.mkDefault true;
    secrets = {
      hetznerStorageboxBackupsHost = {
        reference = "op://opnix/Storagebox-Backups-SA/host";
        path = ".config/rclone/hetzner-storagebox-backups-host";
      };
      hetznerStorageboxBackupsUsername = {
        reference = "op://opnix/Storagebox-Backups-SA/username";
        path = ".config/rclone/hetzner-storagebox-backups-username";
      };
      hetznerStorageboxBackupsPassword = {
        reference = "op://opnix/Storagebox-Backups-SA/password";
        path = ".config/rclone/hetzner-storagebox-backups-password";
      };
      kopiaHetznerBackupsPasswordB64 = {
        reference = "op://opnix/Kopia-Backups-Hetzner/password-base64";
        path = ".config/kopia/repository.config.kopia-password";
      };
    };
  };
  programs.rclone = {
    enable = true;
    remotes = {
      personal-storagebox-hetzner-backups = {
        config = {
          type = "sftp";
          port = "23";
          shell_type = "unix";
          md5sum_command = "md5sum";
          sha1sum_command = "sha1sum";
        };
        secrets = {
          host = config.programs.onepassword-secrets.secretPaths.hetznerStorageboxBackupsHost;
          user = config.programs.onepassword-secrets.secretPaths.hetznerStorageboxBackupsUsername;
          pass = config.programs.onepassword-secrets.secretPaths.hetznerStorageboxBackupsPassword;
        };
      };
    };
  };
  home.file.".config/kopia/repository.config".text = builtins.toJSON {
    hostname = hostname;
    username = "kaja";
    description = "My repository";
    enableActions = false;
    formatBlobCacheDuration = 90000000000;
    caching = {
      cacheDirectory = "/home/kaja/.cache/kopia/hetzner-storagebox";
      maxCacheSize = 5242880000;
      maxMetadataCacheSize = 5242880000;
      maxListCacheDuration = 30;
    };
    storage = {
      type = "rclone";
      config = {
        remotePath = "personal-storagebox-hetzner-backups:kopia";
        rcloneExe = "/home/kaja/.nix-profile/bin/rclone";
        startupTimeout = "0s";
        atomicWrites = false;
      };
    };
  };
  home.packages = [ pkgs.kopia pkgs.kopia-ui ];

  systemd.user = {
    services.kopia = {
      Unit = {
        Description = "Run kopia backups";
        Wants = "network-online.target";
        After = "network-online.target";
      };
      Service = {
        Type = "oneshot";
        Nice = 19;
        CPUSchedulingPolicy = "batch";
        CPUQuota = "200%";
        IOSchedulingPriority = 7;
        ExecStart = lib.getExe (pkgs.writeShellApplication {
          name = "run-kopia-backup";
          runtimeInputs = [ pkgs.kopia pkgs.systemd pkgs.networkmanager ];
          text = ''
            # https://github.com/systemd/systemd/issues/39523 would be a much nicer way of handling this
            while (! systemd-ac-power) || [[ "$(nmcli networking connectivity)" != 'full' ]]; do
              echo "Waiting to backup"
              systemd-ac-power && echo 'Power: True' || echo 'Power: False'
              echo "Networking: $(nmcli networking connectivity)"
              sleep 30
            done
            kopia snapshot create --all
          '';
        });
      };
    };
    timers.kopia = {
      Unit.Description = "Run kopia backups hourly";
      Install.WantedBy = [ "timers.target" ];
      Timer = {
        OnCalendar = "hourly";
        Persistent = true;
      };
    };

  };
}
