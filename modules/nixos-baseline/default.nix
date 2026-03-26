{ lib, config, pkgs, inputs, myOverlaysRoot, ... }: {
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  imports = [
    ./vm-test.nix
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  programs.nh.flake = lib.mkDefault "/etc/nixos";

  # Time and locale and stuff
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_IE.UTF-8";
  i18n.extraLocales = [ "en_GB.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    #LC_NUMERIC = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
  };

  # Keymap
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
    options = "caps:escape";
  };
  console.keyMap = "uk";

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
    "nixpkgs-overlays=${myOverlaysRoot}"
  ];
  nix.settings.trusted-users = config.home-manager-custom.enabledUsers;
  nix.settings.substituters = [
    "https://devenv.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
  ];

  # The Essentials
  programs.neovim.enable = true;
  programs.git.enable = true;
  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = false;
    };
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
  };
}
