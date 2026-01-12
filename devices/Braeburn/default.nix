{ config, inputs, pkgs, myModulesRoot, ... }:
{
  # Default options - always active
  imports = [
    inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
    "${myModulesRoot}/nixos-baseline"
    "${myModulesRoot}/nixos-laptop"
    ./hardware-configuration.nix
  ];

  networking.hostName = "Braeburn"; # Define your hostname.
  home-manager-custom = {
    homeModuleFlags = [ "linux" "desktop" ];
    enabledUsers = [ "kaja" ];
  };

  # Asahi Quirks & Features
  services.fprintd.enable = false; #touch id machine broke
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];
  # Asahi Firmware
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  boot.loader.efi.canTouchEfiVariables = false;
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };
}

