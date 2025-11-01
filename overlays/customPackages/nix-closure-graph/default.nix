{ lib
, stdenv
, makeWrapper
, bash
, jq
, graphviz-nox
}:
stdenv.mkDerivation rec{
  pname = "nix-closure-graph";
  version = "20250813";

  src = ./.;
  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    bash
    jq
    graphviz-nox
  ];

  dontUnpack = true;
  installPhase = ''
    mkdir $out
    cp -r $src/bin $out/bin
    cp -r $src/lib $out/lib
  '';
  preFixup = ''
    wrapProgram $out/bin/nix-closure-graph \
      --prefix PATH : ${lib.makeBinPath [jq graphviz-nox]}
  '';

  meta = {
    description = "Easily display a graph of a derivation's closure";
  };
}
