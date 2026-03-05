{ pkgs, x86Pkgs, osConfig, lib, ... }: {
  home.packages = [
    x86Pkgs.clickup
  ] ++ (
    {
      "x86_64-linux" = [ pkgs.slack ];
      "aarch64-linux" = [ pkgs.slacky ];
    }."${pkgs.hostPlatform.system}"
  );
}
