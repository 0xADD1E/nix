{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cameractrls
  ];

  networking.firewall.enable = false;
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins;[
      obs-ndi
      #obs-distroav #supercedes obs-ndi but isn't in nixpkgs stable yet
      obs-multi-rtmp
      obs-source-record
      obs-pipewire-audio-capture
    ];
  };
}
