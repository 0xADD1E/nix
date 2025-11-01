{ lib, inputs, pkgs, ... }: {
  imports = [ inputs.nix-index-database.homeModules.nix-index ];
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;

  home.packages = with pkgs;[
    (aspellWithDicts (d: [
      d.cs
      d.en
      d.en-computers
    ]))
    curlFull
    du-dust
    hyperfine
    mosh
    nmap
    pv
    rsync
    rclone
    ripgrep
    ripgrep-all
    socat
    watch
    wget
    xz
  ];

  programs.bat.enable = true;
  programs.eza.enable = true;
  home.shellAliases = {
    cat = "bat";
    ls = "eza";
    qr = "${lib.getExe pkgs.qrencode} -t UTF8";
  };

  programs.htop.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
