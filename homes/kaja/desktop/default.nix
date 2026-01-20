{ config, pkgs, unstablePkgs, ... }:
{
  imports = [ ./firefops.nix ./fonts.nix ./vscode.nix ./wezterm ];
  home.packages = with pkgs;[
    openscad
    neovide
    unstablePkgs.signal-desktop
    telegram-desktop
    #unstablePkgs.slack
    chromium
    seafile-client
  ];
  programs.element-desktop.enable = true;
  programs.mpv.enable = true;
}
