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
    dust
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
  programs.difftastic.enable = true;
  home.shellAliases = {
    cat = "bat";
    #ls = "eza";
    qr = "${lib.getExe pkgs.qrencode} -t UTF8";
  };

  programs.htop = {
    enable = true;
    settings = {
      hide_kernel_threads = false;
      hide_userland_threads = true;
      show_cpu_frequency = true;
      show_cpu_temperature = true;
      header_layout = "two_50_50";
    } // (with config.lib.htop; leftMeters [
      (bar "LeftCPUs2")
      (bar "Memory")
      (bar "Swap")
      (text "NetworkIO")
      (text "DiskIO")
    ]) // (with config.lib.htop; rightMeters [
      (bar "RightCPUs2")
      (bar "GPU")
      (text "Tasks")
      (text "LoadAverage")
      (text "Uptime")
    ]);
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
