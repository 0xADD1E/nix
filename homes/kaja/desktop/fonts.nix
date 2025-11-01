{ pkgs, myModulesRoot, ... }: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Calibri" ];
    };
  };
  home.packages = import "${myModulesRoot}/fonts.nix" { inherit pkgs; };
}
