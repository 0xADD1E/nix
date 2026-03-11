{ lib, ... }: {
  services.hardware.bolt.enable = true;
  services.beesd.filesystems = {
    "root" = {
      spec = "/";
      hashTableSizeMB = 4 * 1024;
      extraOptions = let loadTargetFract = 0.25; in [ "--loadavg-target" "${lib.strings.floatToString (loadTargetFract*16)}" ];
    };
  };
}
