{ config, pkgs, unstablePkgs, ... }:
{
  imports = [
    ./backups.nix
    ./chat.nix
    ./firefops.nix
    ./fonts.nix
    ./squashfs-handler.nix
    ./vscode.nix
    ./wezterm
  ];
  home.packages = with pkgs;[
    openscad
    neovide
    unstablePkgs.yt-dlp
    chromium
    seafile-client
    kdenlive-plugin-compatible
  ];
  programs.mpv.enable = true;
}
