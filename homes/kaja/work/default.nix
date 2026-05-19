{ pkgs, x86Pkgs, osConfig, lib, ... }: {
  imports = [
    ./mail.nix
  ];
  home.packages = [
    x86Pkgs.clickup
  ] ++ (
    {
      "x86_64-linux" = [ pkgs.slack ];
      "aarch64-linux" = [ pkgs.slacky ];
    }."${pkgs.stdenv.hostPlatform.system}"
  );
}
