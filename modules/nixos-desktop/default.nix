{ lib, config, pkgs, myModulesRoot, ... }: {
  imports = [
    "${myModulesRoot}/nixos-metal"
    ./libvirt.nix
  ];

  # Graphical Things
  services.xserver.enable = true;
  services.displayManager.sddm.enable = lib.mkDefault true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages;[
    baloo
    milou
    drkonqi
    elisa
    khelpcenter
  ];

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  # Basic Services
  services.printing.enable = true;
  services.openssh = {
    enable = true;
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish.workstation = true;
    publish.userServices = true;
    publish.addresses = true;
  };

  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = config.home-manager-custom.enabledUsers;
  };
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "client";
  };
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
  services.cockpit = {
    enable = true;
    #openFirewall=true;
    allowed-origins = [ "localhost" ];
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
    #TODO: Extra modules like https://fictionbecomesfact.com/notes/cockpit-machines-nixos-setup/ ?
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    autoPrune.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = import "${myModulesRoot}/fonts.nix" { inherit pkgs; };
  };

}
