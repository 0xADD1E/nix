final: prev: {
  zed-editor-rosandbox = (prev.callPackage ./zeditor.nix { }).fhs;
  opencode-desktop = (prev.callPackage ./opencode-desktop.nix { });
}
