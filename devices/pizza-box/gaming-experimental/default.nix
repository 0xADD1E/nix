{ inputs, lib, pkgs, myModulesRoot, ... }: {
  imports = [
    ./jank-pre.nix
    inputs.jovian-nixos.nixosModules.jovian
    ./jank-post.nix
  ];

  services.displayManager.sddm.enable = lib.mkForce false;
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
    steam.environment = {
      #__NV_PRIME_RENDER_OFFLOAD_PROVIDER="NVIDIA-G0";
      #__GLX_VENDOR_LIBRARY_NAME="nvidia";
      #__VK_LAYER_NV_optimus="NVIDIA_only";
      #__NV_PRIME_RENDER_OFFLOAD="1";
    };

    decky-loader.enable = true;
    decky-loader.extraPackages = [ ];
    decky-loader.extraPythonPackages = p: with p;[ ];
  };
}

