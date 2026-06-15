{ inputs, pkgs, unstablePkgs, x86Pkgs, myModulesRoot, myHomesRoot, myOverlaysRoot, system, kind, ... }: {
  imports = [ inputs.microvm.nixosModules.host ];
  microvm.vms = {
    clanker-sandbox = {
      inherit pkgs;
      specialArgs = { inherit system kind unstablePkgs x86Pkgs inputs myModulesRoot myHomesRoot myOverlaysRoot; hostname = "clanker-sandbox"; };
      extraModules = [
        (import myHomesRoot).moduleSetup
        (import myHomesRoot).homeSetup
      ];
      config = {
        microvm = {
          #graphics.enable=true;
          hypervisor = "cloud-hypervisor";
          hotplugMem = 8 * 1024; #8GB
          vsock = {
            cid = 3;
            ssh.enable = true;
          };
          shares = [{
            source = "/nix/store";
            mountPoint = "/nix/.ro-store";
            tag = "ro-store";
            proto = "virtiofs";
            readOnly = true;
          }];
        };
        imports = [
          "${myModulesRoot}/nixos-baseline"
        ];
        home-manager-custom = {
          homeModuleFlags = [ "linux" ];
          enabledUsers = [ "kaja" ];
        };
        environment.systemPackages = [
          pkgs.opencode
          #pkgs.pi-coding-agent
        ];
        environment.sessionVariables = {
          WAYLAND_DISPLAY = "wayland-1";
          DISPLAY = ":0";
          QT_QPA_PLATFORM = "wayland"; # Qt Applications
          GDK_BACKEND = "wayland"; # GTK Applications
          XDG_SESSION_TYPE = "wayland"; # Electron Applications
          SDL_VIDEODRIVER = "wayland";
          CLUTTER_BACKEND = "wayland";
        };
      };
    };
  };
}
