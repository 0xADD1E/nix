final: prev: {
  kubelogin-oidc = (prev.kubelogin-oidc.override { buildGoModule = final.buildGo126Module; }).overrideAttrs (old: rec {
    version = "main-20260320";
    src = final.fetchFromGitHub {
      owner = "int128";
      repo = "kubelogin";
      rev = "3a197652177214c2c226b6f7c532fe15ce7cd2f5";
      hash = "sha256-bQvduq3NFbkjXvhVz2mBFf5M2KG8vh4o4CcY+RxvNtE=";
    };
    ldflags = [
      "-s"
      "-w"
    ];
    vendorHash = "sha256-mh2GzRVOVEomrs57a1Wv+N7Jcu6YnkPeVWWBx6Swojc=";
  });
}
