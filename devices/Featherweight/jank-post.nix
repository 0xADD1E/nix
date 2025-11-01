{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      mesa-radeonsi-jupiter = prev.mesa-radeonsi-jupiter.overrideAttrs (f: p: {
        buildInputs = p.buildInputs ++ [ prev.libpng ];
      });
    })
  ];
}
