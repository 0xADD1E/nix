{ config, pkgs, ... }:
{
  imports = [ ./fonts.nix ./vscode.nix ./wezterm ];
  home.packages = with pkgs;[
    openscad
    neovide
    firefox-bin
    signal-desktop
    slack
    google-chrome
    seafile-client
  ];
  programs.element-desktop.enable = true;
  programs.mpv.enable = true;


}
