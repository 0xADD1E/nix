{ config, pkgs, ... }: {
  imports = [
    ./shells.nix
    ./cli-utils.nix
    ./ssh.nix
    ./git.nix
  ];
  home.packages = with pkgs;[
    nix-closure-graph
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.nh = {
    enable = true;
  };

  programs.aria2.enable = true;
  programs.tmux.enable = true;
  programs.tmate.enable = true;
}
