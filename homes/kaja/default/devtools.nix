{ lib, inputs, pkgs, ... }: {
  home.packages = with pkgs;[
    codespell
    devenv
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
    awscli2
  ];
}
