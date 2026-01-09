{ config, inputs, pkgs, myModulesRoot, ... }:
{
  # Default options - always active
  imports = [
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
    "${myModulesRoot}/nixos-baseline"
    "${myModulesRoot}/nixos-laptop"
    ./hardware-configuration.nix
  ];

  # Asahi Quirks & Firmware
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  boot.loader.efi.canTouchEfiVariables=false;
  networking.wireless.iwd = {
    enable=true;
    settings.General.EnableNetworkConfiguration=true;
  };

  networking.hostName = "braeburn"; # Define your hostname.
  home-manager-custom = {
    homeModuleFlags = [ "linux" ];
    enabledUsers = ["kaja"];
  };
}

