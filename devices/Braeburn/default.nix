{ config, inputs, lib, pkgs, myModulesRoot, ... }:
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

  boot.plymouth.theme = "connect";
  boot.plymouth.themePackages = [ ((pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "connect" ]; }).overrideAttrs { patches = [ ./patch.diff ]; }) ];

  # Asahi Quirks & Features
  boot.kernelPackages = lib.mkForce (pkgs.callPackage ./kernel.nix { });
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

