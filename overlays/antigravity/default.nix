final: prev: {
  antigravity-rosandbox = (prev.callPackage ./antigravity.nix { vscode-generic = "${prev.path}/pkgs/applications/editors/vscode/generic.nix"; }).fhs;
}

