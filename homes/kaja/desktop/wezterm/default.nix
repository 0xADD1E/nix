{ pkgs, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./config.lua;
    package = pkgs.wezterm.overrideAttrs (final: prev: {
      buildInputs = prev.buildInputs ++ [ pkgs.makeWrapper ];
      postInstall = prev.postInstall + ''
        wrapProgram $out/bin/wezterm --run "unset \$(env | cut -d= -f1 | grep -v -E '^(SESSION_MANAGER|DBUS_SESSION_ADDRESS|XAUTHORITY|XDG_|SOMMELIER_|LD_ARGV0_REL|HOME$|USER$)|DISPLAY')"
      '';
    });
  };
}
