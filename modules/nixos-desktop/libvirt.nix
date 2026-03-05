{ pkgs, ... }:
{
  virtualisation.spiceUSBRedirection.enable = true;
  environment.systemPackages = with pkgs; [
    virtiofsd
    swtpm
  ];

  # VMM Bits
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      runAsRoot = false;
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
