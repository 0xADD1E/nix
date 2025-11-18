{ config, inputs, pkgs, myModulesRoot, ... }:

{
  networking.hostName = "baguette-nixos";
  imports =
    [
      inputs.nixos-crostini.nixosModules.baguette
      "${myModulesRoot}/nixos-baseline"
    ];
  home-manager-custom.homeModuleFlags = [ "linux" ];
}
