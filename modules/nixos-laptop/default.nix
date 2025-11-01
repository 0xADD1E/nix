{ config, pkgs, myModulesRoot, ... }: {
  imports = [ "${myModulesRoot}/nixos-desktop" ];
  services.fprintd.enable = true;
}
