{}: {
  description = "Karolina Liskova";
  extraGroups = [ "networkmanager" "wheel" "docker" "libvirt" ];
  homeModule = { lib, config, osConfig, ... }:
    let
      ifFlag = flagName: modulePath: (lib.optional (builtins.elem flagName osConfig.home-manager-custom.homeModuleFlags) modulePath);
    in
    {
      home.stateVersion = "25.05";
      imports = [ ./default ] ++ (ifFlag "desktop" ./desktop) ++ (ifFlag "linux" ./linux) ++ (ifFlag "deck" ./deck);
    };
}
