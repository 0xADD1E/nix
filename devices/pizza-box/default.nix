{ config, pkgs, myModulesRoot, ... }:
let defaultSpecialisationModules = [ ./gaming ]; in {
  # Default options - always active
  imports = [
    "${myModulesRoot}/nixos-baseline"
    "${myModulesRoot}/nixos-desktop"
    ./hardware-configuration.nix
  ] ++ defaultSpecialisationModules;

  specialisation = {
    obs.configuration = { ... }: {
      imports = [ ./broadcast ];
      disabledModules = defaultSpecialisationModules;
    };
    vfio.configuration = { ... }: {
      imports = [ ./vfio ];
      disabledModules = defaultSpecialisationModules;
    };
  };

  networking.hostName = "pizza-box"; # Define your hostname.


  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "user";

  programs.firefox.enable = true;
  boot.plymouth.logo = ./goodpup_logo.png;
}
