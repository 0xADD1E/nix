final: prev:
let
  lixPackages = prev.lixPackageSets.stable;
in
{
  colmena = prev.colmena.override {
    nix = lixPackages.lix;
    inherit (lixPackages) nix-eval-jobs;
  };
  nix-direnv = prev.nix-direnv.override {
    nix = lixPackages.lix;
  };
  nix-fast-build = prev.nix-fast-build.override {
    inherit (lixPackages) nix-eval-jobs;
  };
  nixpkgs-review = prev.nixpkgs-review.override {
    nix = lixPackages.lix;
  };
}
