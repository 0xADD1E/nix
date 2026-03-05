final: prev:
with prev.lib;
let
  packagesDir = (builtins.readDir ./.);
  filenames = builtins.attrNames packagesDir;
  toImport = builtins.filter (f: (f != "default.nix")) filenames;
  # Load the system config and get the `nixpkgs.overlays` option
  overlays = map
    (filename: (final: prev: {
      "${filename}" = (prev.callPackage (./. + "/${filename}") {
        muvm = prev.muvm;
      });
    }))
    toImport;
in
# Apply all overlays to the input of the current "main" overlay
foldl' (flip extends) (_: prev) overlays final

