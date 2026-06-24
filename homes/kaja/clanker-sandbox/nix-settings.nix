{ ... }: {

  home.file.".local/share/nix/trusted-settings.json".text = builtins.toJSON {
    "extra-substituters" = { "https://devenv.cachix.org" = true; };
    "extra-trusted-public-keys" = { "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" = true; };
  };
}
