{}: {
  description = "Local User";
  extraGroups = [ "networkmanager" ];
  homeModule = { lib, config, osConfig, ... }:
    let
      ifFlag = flagName: modulePath: (lib.optional (builtins.elem flagName osConfig.home-manager-custom.homeModuleFlags) modulePath);
    in
    {
      home.stateVersion = "25.05";
      imports = [ ./default ];
    };
}

