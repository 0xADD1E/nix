final: prev: {
  kubelogin-oidc = (prev.kubelogin-oidc.override { buildGoModule = final.buildGoModule; }).overrideAttrs (old: rec {
    version = "0xADD1E-20250514";
    src = final.fetchFromGitHub {
      owner = "0xADD1E";
      repo = "kubelogin";
      rev = "v20250514";
      hash = "sha256-bkiZ0BF5jJWWgeai0QPOm06Gltv4HbXllHX8TQnwfAc=";
    };
    ldflags = [
      "-s"
      "-w"
    ];
    vendorHash = "sha256-Q3IFvzmC/BV1vgGv+3nTYFRlajrbdSdeGJiydnZWqog=";
  });
}
