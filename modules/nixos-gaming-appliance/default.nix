{ pkgs, ... }: {
  boot.plymouth.theme = "colorful_loop";
  boot.plymouth.themePackages = [ (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "colorful_loop" "rings_2" ]; }) ];

  users.users.user.extraGroups = [ "wheel" "libvirtd" ];
  security.sudo = {
    extraRules = [{
      commands = [
        { command = "ALL"; options = [ "NOPASSWD" ]; }
      ];
      groups = [ "wheel" ];
    }];
  };
}
