{ config, pkgs, ... }:
{
  home.packages = with pkgs;[
    spoof-mac
    m-cli
  ];
  home.shellAliases = {
    tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
    flush-dns = "sudo sh -c 'dscacheutil -flushcache;killall -HUP mDNSResponder'";
    switch-mac = "sudo spoof-mac randomize en0";
  };
  home.sessionVariables = {
    NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
  };
  home.sessionSearchVariables = {
    PATH = [
      "$HOME/.rd/bin"
      "$HOME/.local/bin"
      "$HOME/.nix-profile/bin"
      "/etc/profiles/per-user/kaja/bin"
      "/run/current-system/sw/bin"
      "$HOME/.cargo/bin"
      "$HOME/.krew/bin"
      "$HOME/.yarn/bin"
      "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
      "/usr/local/bin"
      "/System/Cryptexes/App/usr/bin"
      "/usr/bin"
      "/bin"
      "/usr/sbin"
      "/sbin"
      "/opt/X11/bin"
      "/Library/Apple/usr/bin"
      "/opt/homebrew/bin"
    ];
  };
}
