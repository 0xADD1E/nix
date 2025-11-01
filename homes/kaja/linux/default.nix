{ config, pkgs, ... }:
{
  home.packages = with pkgs;[
    rclone-browser
    rnote
  ];
  home.shellAliases = {
    open = "xdg-open";
    pbcopy = "${pkgs.wl-clipboard}/bin/wl-copy";
    pbpaste = "${pkgs.wl-clipboard}/bin/wl-paste";
  };
}
