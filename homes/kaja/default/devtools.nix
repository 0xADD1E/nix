{ lib, inputs, pkgs, ... }: {
  home.packages = with pkgs;[
    codespell
    devenv
    nil
    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
        "clippy"
      ];
    })

    docker-credential-helpers
    stern
    kubectl
    kind
    kubelogin-oidc
    (pkgs.writeShellScriptBin "kubelogin-oidc-browserhelper" ''
      ${pkgs.xdg-utils}/bin/xdg-open "$(echo "$1" | ${pkgs.gnused}/bin/sed 's/localhost/127.0.0.1/g')#reopen-in-workcontainer"
    '')
    awscli2
    antigravity-rosandbox

    freelens-bin
  ];
}
