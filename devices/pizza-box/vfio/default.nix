{ inputs, lib, pkgs, ... }:
{
  imports = [ inputs.nixos-vfio.nixosModules.vfio ./virt-clients.nix ];
  environment.systemPackages = with pkgs; [
    virtiofsd
  ];

  # VMM Bits
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      runAsRoot = false;
      ovmf.enable = true;
      swtpm.enable = true;
    };
    deviceACL = [
      "/dev/kvm"
      "/dev/kvmfr0"
      "/dev/kvmfr1"
      "/dev/kvmfr2"
      "/dev/shm/scream"
      "/dev/shm/looking-glass"
      "/dev/null"
      "/dev/full"
      "/dev/zero"
      "/dev/random"
      "/dev/urandom"
      "/dev/ptmx"
      "/dev/kvm"
      "/dev/kqemu"
      "/dev/rtc"
      "/dev/hpet"
      "/dev/vfio/vfio"
    ];
  };

  # TODO: Hugepages
  # https://j-brn.github.io/nixos-vfio/options.html#virtualisationhugepagesenable

  # TODO: Declarative domains
  # https://j-brn.github.io/nixos-vfio/options.html#virtualisationlibvirtdqemudomainsdeclarative

  # VFIO/KVMFR
  virtualisation.vfio = {
    enable = true;
    IOMMUType = "amd";
    devices = [
      "10de:2204" # NVIDIA GA102 (RTX 3090) VGA
      "10de:1aef" # NVIDIA GA102 (RTX 3090) HD Audio
      #"144d:a804" # Samsung NVMe SSD

      ##"1022:43f6" # AMD SATA Controller

      ## AMD Raphael/Granite Ridge USB 3.1 Controllers
      #"1022:15b7" # The pair of blue ones on the back (10:00.4)
      ##"1022:15b6" # The pair of red ones on the back (10:00.3)
      # The other usb ports can't be (easily) selected for exclusive passthrough.
      # They technically can, it's 1022:43f7 (0e:00.0) for all of them BUT that's also got the
      # lighting, audio, and some of the wireless/bluetooth devices permanently attached to it
      # (meaning for it to actually work, you'd also need to pass through the PCI device for WiFi)
      # This is possible, it's 14c3:0616 (0d:00.0) but it's a whole headache (especially with
      # power management) and it's easier to use spice for hotplugging USB devices on other ports
    ];
  };

  #TODO: Do we need to do more in depth config on devices?
  virtualisation.kvmfr = {
    enable = true;
    devices = [{
      #resolution = {
      #  width=3840;
      #  height=2160;
      #  pixelFormat="rgba32";
      #};
      size = 256; # Source: Bro just trust me (it's probably equiv to what the resolution bits would say)
      permissions = {
        user = "user";
        mode = "0777";
      };
    }];
  };
  /*
    boot.initrd.availableKernelModules = [ "vfio-pci" ];
    boot.initrd.preDeviceCommands = ''
    DEVS="01:00.0 01:00.1 05:00.0 10:00.3" #pci that you want to pass to the vm
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/0000:$DEV/driver_override
    done
    modprobe -i vfio-pci
    '';
    boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
    boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];
  */

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 user qemu-libvirtd -"
    "f /dev/shm/scream 0660 user qemu-libvirtd -"
  ];
}
