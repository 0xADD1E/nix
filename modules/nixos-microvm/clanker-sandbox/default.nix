{ myModulesRoot, pkgs, ... }: {
  imports = [
    "${myModulesRoot}/nixos-baseline"
  ];
  home-manager-custom = {
    homeModuleFlags = [ "linux" "clanker-sandbox" ];
    enabledUsers = [ "kaja" ];
  };
  environment.systemPackages = [
    pkgs.opencode
  ];
  systemd.services.opencode = {
    description = "OpenCode Clanker Manager";
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    environment = {
      OPENCODE_SERVER_PASSWORD = "opencode";
    };
    path = [ ];
    serviceConfig = {
      User = "kaja";
      ExecStart = "${pkgs.opencode}/bin/opencode serve --hostname 0.0.0.0";
    };
  };

}
