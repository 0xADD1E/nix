{ config, pkgs, myModulesRoot... }: {
  inputs = [
    "${myModulesRoot}/gaming"
    ./hardware.nix
    # ./gamescope.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris
  ];

  programs.steam.package = pkgs.steam.override {
    extraEnv = {
      #MANGOHUD=true; # Needs more configuration or something to be less intrusive or at least possible to disable easily
      "__NV_PRIME_RENDER_OFFLOAD" = 1;
      "__NV_PRIME_RENDER_OFFLOAD_PROVIDER" = "NVIDIA-G0";
      "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
      "__VK_LAYER_NV_optimus" = "NVIDIA_only";
    };
    extraPkgs = pkgs': with pkgs'; [
      mangohud
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib # Provides libstdc++.so.6
      libkrb5
      keyutils
      # Add other libraries as needed
    ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
