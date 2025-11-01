{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-vfio.url = "github:j-brn/nixos-vfio";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    nixgl.url = "github:nix-community/nixGL";
    rust-overlay.url = "github:oxalica/rust-overlay";
    firefox.url = "github:mozilla/nixpkgs-mozilla";
    nix-index-database.url = "github:nix-community/nix-index-database";
    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";

    # Only one nixpkgs
    nixos-vfio.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    jovian-nixos.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, ... }:
    let
      specialArgs = { inherit inputs; myModulesRoot = ./modules; myOverlaysRoot = ./overlays; };
      hosts = [
        { hostname = "fluttershy"; system = "x86_64-linux"; kind = "homemanager"; }
        { hostname = "penguin"; system = "x86_64-linux"; kind = "homemanager"; }
        { hostname = "Nightmare-Moon"; system = "aarch64-darwin"; kind = "nixdarwin"; }
        { hostname = "Zephyr-Breeze"; system = "x86_64-linux"; kind = "nixos"; }
        { hostname = "Featherweight"; system = "x86_64-linux"; kind = "nixos"; }
        { hostname = "pizza-box"; system = "x86_64-linux"; kind = "nixos"; }
      ];
      hostsByKind = builtins.groupBy (h: h.kind) hosts;
      genHostConfig = ({ hosts, fn }: builtins.listToAttrs (builtins.map (host: fn { inherit (host) system hostname kind; }) hosts));
      nixCfg = (system: {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          inputs.rust-overlay.overlays.default
          inputs.nixgl.overlay
          inputs.firefox.overlays.firefox
          (import ./overlays)
        ];
      });
    in
    rec{
      nixosConfigurations = genHostConfig {
        hosts = hostsByKind.nixos;
        fn = { system, hostname, kind }: {
          name = hostname;
          value = nixpkgs.lib.nixosSystem {
            inherit system;
            pkgs = import nixpkgs (nixCfg system);
            specialArgs = specialArgs // { inherit kind; };
            modules = [
              (import ./homes).moduleSetup
              "${./devices}/${hostname}"
              (import ./homes).homeSetup
            ];
          };
        };
      };
      homeConfigurations = genHostConfig {
        hosts = hostsByKind.homemanager;
        fn = { system, hostname, kind }: {
          name = "kaja@${hostname}";
          value = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import nixpkgs (nixCfg system);
            extraSpecialArgs = specialArgs // { inherit kind; osConfig.home-manager-custom.homeModuleFlags = [ "standalone" ]; };
            modules = [ "${./devices}/${hostname}" ];
          };
        };
      };
      darwinConfigurations = genHostConfig {
        hosts = hostsByKind.nixdarwin;
        fn = { system, hostname, kind }: {
          name = hostname;
          value = inputs.nix-darwin.lib.darwinSystem {
            inherit system;
            pkgs = import nixpkgs (nixCfg system);
            specialArgs = specialArgs // { inherit kind; };
            modules = [
              (import ./homes).moduleSetup
              "${./devices}/${hostname}"
              (import ./homes).homeSetup
            ];
          };
        };
      };

      formatter = builtins.mapAttrs (s: p: p.nixpkgs-fmt) nixpkgs.legacyPackages;
      packages = builtins.mapAttrs (s: _p: (import nixpkgs (nixCfg s))) nixpkgs.legacyPackages;
      apps = let hostsByArch = builtins.groupBy (h: h.system) hostsByKind.nixos; in builtins.mapAttrs
        (system: hosts: genHostConfig {
          inherit hosts;
          fn = { hostname, ... }: {
            name = "vmtest-${hostname}";
            value = {
              type = "app";
              program = "${nixpkgs.lib.getExe nixosConfigurations."${hostname}".config.system.build.vm}";
            };
          };
        })
        hostsByArch;
    };
}

