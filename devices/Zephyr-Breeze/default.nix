{ config, pkgs, myModulesRoot, ... }:

{
  networking.hostName = "Zephyr-Breeze";
  boot.plymouth.theme = "cross_hud";
  boot.plymouth.themePackages = [ (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "cross_hud" ]; }) ];
  imports =
    [
      ./hardware-configuration.nix
      "${myModulesRoot}/nixos-baseline"
      "${myModulesRoot}/nixos-laptop"
      "${myModulesRoot}/gaming"
    ];
  home-manager-custom.homeModuleFlags = [ "desktop" "linux" ];
  programs.nh.flake = "/etc/nixos";

  # Install firefox.
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    unigine-superposition
    kdePackages.kate
  ];
}
