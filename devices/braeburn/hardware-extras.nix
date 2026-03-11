{ lib, pkgs, ... }: {
  services.beesd.filesystems = {
    "root" = {
      spec = "/";
      hashTableSizeMB = 1 * 1024;
      extraOptions = let loadTargetFract = 0.25; in [ "--loadavg-target" "${lib.strings.floatToString (loadTargetFract*16)}" ];
    };
  };

  # Asahi Quirks & Features
  boot.kernelPackages = lib.mkForce (pkgs.callPackage ./kernel.nix { });
  services.fprintd.enable = false; #touch id machine broke
  boot.kernelParams = [ "appledrm.show_notch=1" ]; #formerly known as apple_dcp.show_notch
  # Asahi Firmware
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  boot.loader.efi.canTouchEfiVariables = false;
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };
}
