{ inputs, pkgs, unstablePkgs, x86Pkgs, myModulesRoot, myHomesRoot, myOverlaysRoot, system, kind, ... }: {
  imports = [ inputs.microvm.nixosModules.host ];
  microvm.vms = {
    clanker-sandbox = {
      inherit pkgs;
      specialArgs = { inherit system kind unstablePkgs x86Pkgs inputs myModulesRoot myHomesRoot myOverlaysRoot; hostname = "clanker-sandbox"; };
      extraModules = [
        (import myHomesRoot).moduleSetup
        (import ./clanker-sandbox)
        (import ./writable-store-overlay.nix)
        (import myHomesRoot).homeSetup
      ];
      config = {
        users.users.root.password = "toor";
        users.users.kaja.password = "kaja";
        services.openssh.settings.PermitRootLogin = "yes";
        microvm = {
          #graphics.enable=true;
          #hypervisor = "cloud-hypervisor";
          hypervisor = "qemu";
          qemu.machine = "q35";
          hotplugMem = 32 * 1024; #8GB
          vsock = {
            cid = 3;
            ssh.enable = true;
          };
          shares = [
            {
              source = "/home/kaja/Documents/Sandbox/.opencode-mem";
              mountPoint = "/home/kaja/.opencode-mem";
              tag = "opencode-mem";
              proto = "virtiofs";
              readOnly = false;
            }
            {
              source = "/home/kaja/Documents/Sandbox/.local";
              mountPoint = "/home/kaja/.local";
              tag = "local";
              proto = "virtiofs";
              readOnly = false;
            }
            {
              source = "/home/kaja/Documents/Sandbox/.cache";
              mountPoint = "/home/kaja/.cache";
              tag = "cache";
              proto = "virtiofs";
              readOnly = false;
            }
            {
              source = "/home/kaja/Documents/Sandbox/Documents";
              mountPoint = "/home/kaja/Documents";
              tag = "documents";
              proto = "virtiofs";
              readOnly = false;
            }
          ];
          interfaces = [{
            type = "user";
            id = "n0";
            mac = "02:00:00:00:00:02";
          }];
          forwardPorts = [
            { from = "host"; host.port = 4096; guest.port = 4096; }
          ];
        };
        networking.firewall.enable = false;
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
