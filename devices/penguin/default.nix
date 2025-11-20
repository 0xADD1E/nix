{ config, inputs, pkgs, myModulesRoot, ... }:

{
  networking.hostName = "penguin";
  imports =
    [
      inputs.nixos-crostini.nixosModules.baguette
      "${myModulesRoot}/nixos-baseline"
    ];
  home-manager-custom.homeModuleFlags = [ "linux" ];
}
