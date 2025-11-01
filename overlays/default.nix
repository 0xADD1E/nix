final: prev:
with prev.lib;
let
  overlayDir = (builtins.readDir ./.);
  filenames = builtins.attrNames overlayDir;
  toImport = builtins.filter (f: (f != "default.nix")) filenames;
  # Load the system config and get the `nixpkgs.overlays` option
  overlays = map (filename: import (./. + "/${filename}")) toImport;
in
# Apply all overlays to the input of the current "main" overlay
foldl' (flip extends) (_: prev) overlays final
