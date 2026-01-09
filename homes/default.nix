let
  # Import all user descriptions (subdirectories of this)
  # Must expose description, extraGroups, and homeModule
      usersDir = (builtins.readDir ./.);
      filenames = builtins.attrNames usersDir;
      toRegister = builtins.filter (f: (f != "default.nix")) filenames;
      usersAttrs = usernames: builtins.listToAttrs (builtins.map
        (f:
          let
            m = import (./. + "/${f}") { };
          in
          {
            name = f;
            value = { inherit (m) description extraGroups homeModule; };
          }
        )
        usernames);
in
{
  moduleSetup = { lib, inputs, kind, ... }: ({
    # Setup a couple options to allow us to configure our multi-user/multi-device home-manager configuration more ergonomically
    options = {
      home-manager-custom = {
        homePathPrefix = lib.mkOption {
          type = lib.types.path;
          default = "/home";
          example = "/Users";
          description = "homeDirPath = homePathPrefix + username";
        };
        homeModuleFlags = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          example = "[\"desktop\" \"laptop\"]";
          description = "Relatively free-form flags that your home module can use to pick up device-specific features";
        };
        enabledUsers = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = toRegister;
          example = "[\"kaja\"]";
          description = "Which user modules to enable";
        };
      };
    };
  } // (
    # Bring in each platform's home-manager module (and any other config needed to make home-manager work)
    if kind == "nixos" then {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      config = {
        home-manager-custom.homePathPrefix = "/home";
        # If we're on nixos, configure the users at this time
        users.users = lib.mapAttrs
          (username: attrs: {
            inherit (attrs) description extraGroups;
            isNormalUser = true;
          })
          (usersAttrs config.home-manager-custom.enabledUsers);
      };
    } else if kind == "nixdarwin" then {
      imports = [ inputs.home-manager.darwinModules.home-manager ];
      config.home-manager-custom.homePathPrefix = "/Users";
    } else { }
  ));


  # home-manager gets setup (almost) the same across platforms,
  # it's only the module itself (and user path setup) that's platform-specific
  homeSetup = { lib, config, specialArgs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = false;
      extraSpecialArgs = specialArgs;
      users = lib.mapAttrs
        (username: attrs: {
          home.username = username;
          home.homeDirectory = "${config.home-manager-custom.homePathPrefix}/${username}";
          programs.home-manager.enable = true;
          home.sessionVariables.NIX_PATH = (lib.concatStringsSep ":" config.nix.nixPath);
          imports = [ attrs.homeModule ];
        })
        (usersAttrs config.home-manager-custom.enabledUsers);
    };
  };
}
