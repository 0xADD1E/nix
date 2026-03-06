{ pkgs, unstablePkgs, ... }: {
  programs.element-desktop.enable = true;
  home.packages = [
    unstablePkgs.signal-desktop # Requires regular updates
    pkgs.telegram-desktop
    pkgs.whatsapp-electron
  ];
}
