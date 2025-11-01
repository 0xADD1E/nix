{ inputs, pkgs, myModulesRoot, ... }: {
  networking.hostName = "Featherweight";
  imports = [
    ./hardware-configuration.nix
    ./jank-pre.nix
    inputs.jovian-nixos.nixosModules.jovian
    ./jank-post.nix
    "${myModulesRoot}/nixos-baseline"
    "${myModulesRoot}/nixos-metal"
    "${myModulesRoot}/nixos-gaming-appliance"
  ];
  home-manager-custom.homeModuleFlags = [ "deck" "linux" ];

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages;[
    baloo
    milou
    drkonqi
    elisa
    khelpcenter
  ];

  jovian = {
    devices.steamdeck.enable = true;
    devices.steamdeck.autoUpdate = true;
    devices.steamdeck.enableGyroDsuService = true;
    hardware.has.amd.gpu = true;

    steam.enable = true;
    steam.autoStart = true;
    steam.user = "user";
    steam.desktopSession = "plasma";

    decky-loader.enable = true;
    decky-loader.extraPackages = [ ];
    decky-loader.extraPythonPackages = p: with p;[ ];
  };
}
