{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    scream
    looking-glass-client
  ];
  # Clients
  virtualisation.spiceUSBRedirection.enable = true;
  systemd.user.services.scream-ivshmem = {
    enable = true;
    description = "Scream IVSHMEM";
    serviceConfig = {
      ExecStart = "${pkgs.scream}/bin/scream -m /dev/shm/scream";
      Restart = "always";
    };
    wantedBy = [ "multi-user.target" ];
    requires = [ "pipewire-pulse.socket" ];
  };
}
