{ config, pkgs, myModulesRoot, ... }:
let defaultSpecialisationModules = [ ./gaming ./gaming-experimental ]; in {
  # Default options - always active
  imports = [
    "${myModulesRoot}/nixos-baseline"
    "${myModulesRoot}/nixos-desktop"
    ./hardware-configuration.nix
  ] ++ defaultSpecialisationModules;

  specialisation = {
    gaming-fallback.configuration = { ... }: {
      imports = [ ./non-gamingappliance ];
      disabledModules = [ ./gaming-experimental ];
    };
    obs.configuration = { ... }: {
      imports = [ ./broadcast ./non-gamingappliance ];
      disabledModules = defaultSpecialisationModules;
    };
    vfio.configuration = { ... }: {
      imports = [ ./vfio ./non-gamingappliance ];
      disabledModules = defaultSpecialisationModules;
    };
  };

  networking.hostName = "pizza-box"; # Define your hostname.

  programs.firefox.enable = true;
  boot.plymouth.logo = ./goodpup_logo.png;
}
