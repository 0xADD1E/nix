{ config, pkgs, ... }:
{
  hardware.xpadneo.enable = true;
  environment.systemPackages = with pkgs;[
    libresplit
    mesa-demos
  ];
  programs.steam = {
    enable = true;
    extest.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
