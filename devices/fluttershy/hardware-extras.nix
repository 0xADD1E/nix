{ lib, pkgs, ... }: {
  services.hardware.bolt.enable = true;
  services.beesd.filesystems = {
    "root" = {
      spec = "/";
      hashTableSizeMB = 4 * 1024;
      extraOptions = let loadTargetFract = 0.25; in [ "--loadavg-target" "${lib.strings.floatToString (loadTargetFract*16)}" ];
    };
  };
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "fix-touchpad-suspend" ''
      if [ "$USER" != "root" ]; then
        echo "Uses rmmod and modprobe; must be run as root"
        exit 1
      fi
      ${pkgs.kmod}/bin/rmmod i2c_hid_acpi
      ${pkgs.kmod}/bin/modprobe i2c_hid_acpi
    '')
  ];
}
