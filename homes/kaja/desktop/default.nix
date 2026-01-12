{ config, pkgs, ... }:
{
  imports = [ ./firefops.nix ./fonts.nix ./vscode.nix ./wezterm ];
  home.packages = with pkgs;[
    openscad
    neovide
    signal-desktop
    telegram-desktop
    #slack
    #google-chrome
    seafile-client
  ];
  programs.element-desktop.enable = true;
  programs.mpv.enable = true;
}
