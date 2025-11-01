{ config, pkgs, lib, ... }:
{
  virtualisation = rec{
    vmVariant =
      let
        allUsers = config.users.users;
        allUsernames = builtins.attrNames allUsers;
        normalUsers = builtins.filter (username: allUsers."${username}".isNormalUser) allUsernames;
      in
      {
        users.users = lib.genAttrs normalUsers (username: { initialPassword = "test"; });
        virtualisation = {
          memorySize = 2048;
          cores = 4;
        };
      };
  };
}
