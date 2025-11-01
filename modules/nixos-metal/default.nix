{ config, pkgs, myModulesRoot, ... }: {
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.kernelParams = [ "quiet" ];
  # Workaround for https://github.com/NixOS/nixpkgs/issues/266804
  #boot.plymouth.use-simpledrm=true;
  hardware.enableAllHardware = true;

  # Networking
  networking.networkmanager.enable = true;
}
