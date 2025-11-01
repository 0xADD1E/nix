{ config, pkgs, ... }: {
  imports = [ ./patched_xone.nix ];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    steam-hardware.enable = true;

    graphics.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      prime = {
        offload = {
          enable = true;
          offloadCmdMainProgram = "nvidia-offload";
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:1:0:0";
        amdgpuBusId = "PCI:16:0:0";
      };
    };
  };
}
