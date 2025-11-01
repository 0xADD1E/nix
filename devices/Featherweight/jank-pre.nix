{ config, lib, ... }: {
  options = {
    services.logind.settings.Login.HandlePowerKey = lib.mkOption {
      type = lib.types.str;
      default = "poweroff";
    };
  };
  config = {
    services.logind.powerKey = config.services.logind.settings.Login.HandlePowerKey;
  };
}
