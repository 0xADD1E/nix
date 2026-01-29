{ config, pkgs, unstablePkgs, ... }:
{
  imports = [ ./firefops.nix ./fonts.nix ./vscode.nix ./wezterm ];
  home.packages = with pkgs;[
    openscad
    neovide
    unstablePkgs.signal-desktop # Requires regular updates
    telegram-desktop
    #slacky
    chromium
    seafile-client
    kdenlive-plugin-compatible
  ];
  programs.element-desktop.enable = true;
  programs.mpv.enable = true;
}
