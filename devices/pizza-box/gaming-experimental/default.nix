{ inputs, pkgs, myModulesRoot, ... }: {
  imports = [
    ./jank-pre.nix
    inputs.jovian-nixos.nixosModules.jovian
    ./jank-post.nix
  ];

  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages;[
    baloo
    milou
    drkonqi
    elisa
    khelpcenter
  ];

  jovian = {
    steam.enable = true;
    steam.autoStart = true;
    steam.user = "user";
    steam.desktopSession = "plasma";

    decky-loader.enable = true;
    decky-loader.extraPackages = [ ];
    decky-loader.extraPythonPackages = p: with p;[ ];
  };
}

