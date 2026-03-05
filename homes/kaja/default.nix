{}: {
  description = "Karolina Liskova";
  extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  homeModule = { lib, config, osConfig, ... }:
    let
      allFlags = osConfig.home-manager-custom.homeModuleFlags;
      modules = {
        desktop = ./desktop;
        linux = ./linux;
        deck = ./deck;
        work = ./work;
      };
    in
    {
      home.stateVersion = "25.05";
      imports = [ ./default ] ++ (builtins.map (flag: modules."${flag}") allFlags);
    };
}
