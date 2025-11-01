{ kind, pkgs, ... }: {
  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -gx SHELL ${pkgs.fish}/bin/fish
    '';
  };


  programs.fzf.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      time.disabled = false;
      kubernetes.disabled = false;
      cmd_duration.show_milliseconds = true;
      sudo.disabled = false;
      nix_shell = {
        format = "via [$symbol$name$state]($style) ";
        impure_msg = "";
        pure_msg = " (pure)";
      };
    };
  };
}
