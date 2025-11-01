{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
  ];

  networking.firewall.allowedTCPPorts = [ 8080 ];
  services.xserver.desktopManager.kodi.enable = true;

  services.xserver.desktopManager.kodi.package = pkgs.callPackage ./kodi { };
  #TODO: Get steam working first
  #services.displayManager.defaultSession = "kodi";
}
