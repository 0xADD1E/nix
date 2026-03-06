{ config, pkgs, unstablePkgs, ... }:
{
  imports = [
    ./backups.nix
    ./firefops.nix
    ./fonts.nix
    ./squashfs-handler.nix
    ./vscode.nix
    ./wezterm
  ];
  home.packages = with pkgs;[
    openscad
    neovide
    unstablePkgs.signal-desktop # Requires regular updates
    unstablePkgs.yt-dlp
    telegram-desktop
    #slacky
    chromium
    seafile-client
    kdenlive-plugin-compatible
  ];
  programs.element-desktop.enable = true;
  programs.mpv.enable = true;
}
