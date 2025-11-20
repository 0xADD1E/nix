{ config, lib, inputs, pkgs, myModulesRoot, ... }:

{
  networking.hostName = lib.mkForce "penguin";
  imports =
    [
      inputs.nixos-crostini.nixosModules.baguette
      "${myModulesRoot}/nixos-baseline"
    ];
  home-manager-custom.homeModuleFlags = [ "linux" ];
  environment.variables = {
    NIX_REMOTE="daemon";
  };
  security.sudo = {
    extraRules = [{
      commands = [
        { command = "ALL"; options = [ "NOPASSWD" ]; }
      ];
      groups = [ "wheel" ];
    }];
  };
}
