{ config, inputs, lib, pkgs, myModulesRoot, ... }: {
  imports = [
    "${myModulesRoot}/nixos-baseline"
    "${myModulesRoot}/nixos-laptop"
    ./hardware-configuration.nix
    ./hardware-extras.nix
  ];
  networking.hostName = "fluttershy";
  home-manager-custom = {
    homeModuleFlags = [ "linux" "desktop" "work" ];
    enabledUsers = [ "kaja" ];
  };

}
