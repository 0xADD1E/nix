{ config, pkgs, myModulesRoot, ... }:

{
  networking.hostName = "Zephyr-Breeze";
  boot.plymouth.theme = "rings_2";
  boot.plymouth.themePackages = [ (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "colorful_loop" "rings_2" ]; }) ];
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
