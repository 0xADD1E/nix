{ lib, pkgs, ... }: {
  services.displayManager.sddm.enable = lib.mkDefault true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages;[
    baloo
    milou
    drkonqi
    elisa
    khelpcenter
  ];
  environment.systemPackages = [
    pkgs.kdePackages.konqueror
  ];
}
