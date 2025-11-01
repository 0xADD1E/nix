{ config, pkgs, ... }:
let
  xone = config.boot.kernelPackages.xone.overrideAttrs rec{
    version = "0.4.8";
    src = pkgs.fetchFromGitHub {
      owner = "dlundqvist";
      repo = "xone";
      tag = "v${version}";
      hash = "sha256-EXJBqzO4e2SJGrPvB0VYzIQf09uo5OfNdBQw5UqskYg=";
    };
  };
  xow_dongle-firmware = pkgs.xow_dongle-firmware.overrideAttrs rec{
    version = "2017-07";
    src = pkgs.fetchurl {
      url = "http://download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/07/1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e.cab";
      sha256 = "013g1zngxffavqrk5jy934q3bdhsv6z05ilfixdn8dj0zy26lwv5";
    };
  };
in
{
  boot = {
    blacklistedKernelModules = [ "xpad" "mt76x2u" ];
    extraModulePackages = [ xone ];
  };
  hardware = {
    firmware = [ xow_dongle-firmware ];
    xpad-noone.enable = true;
  };
}
