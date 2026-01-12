{ lib, config, pkgs, myModulesRoot, ... }: {
  imports = [ "${myModulesRoot}/nixos-desktop" ];
  services.fprintd.enable = lib.mkDefault true;
  hardware.bluetooth.enable = lib.mkDefault true;
}
