{ config, pkgs, ... }:
{
  home.packages = with pkgs;[
    rclone-browser
    rnote
  ];
  home.shellAliases = {
    pbcopy = "${pkgs.wl-clipboard}/bin/wl-copy";
    pbpaste = "${pkgs.wl-clipboard}/bin/wl-paste";
  };
}
