{ myModulesRoot, pkgs, ... }:
let runAsUser = "kaja"; in {
  imports = [
    "${myModulesRoot}/nixos-baseline"
  ];
  home-manager-custom = {
    homeModuleFlags = [ "linux" "clanker-sandbox" ];
    enabledUsers = [ "${runAsUser}" ];
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
    path = [ "/home/${runAsUser}/.nix-profile/bin" "/run/current-system/sw/bin/nix" ];
    serviceConfig = {
      User = runAsUser;
      ExecStart = "${pkgs.opencode}/bin/opencode serve --hostname 0.0.0.0";
    };
  };

}
