{ config, inputs, lib, pkgs, myModulesRoot, ... }:
{
  # Default options - always active
  imports = [
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
    "${myModulesRoot}/nixos-baseline"
    "${myModulesRoot}/nixos-laptop"
    ./hardware-configuration.nix
    ./hardware-extras.nix
    ./muvm-fex.nix
  ];

  networking.hostName = "braeburn"; # Define your hostname.
  home-manager-custom = {
    homeModuleFlags = [ "linux" "desktop" "work" ];
    enabledUsers = [ "kaja" ];
  };

  boot.plymouth.theme = "connect";
  boot.plymouth.themePackages = [ ((pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "connect" ]; }).overrideAttrs { patches = [ ./patch.diff ]; }) ];

}

