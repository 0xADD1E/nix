{ bun
, cargo
, cargo-tauri
, dbus
, glib
, glib-networking
, gst_all_1
, gtk3
, jq
, lib
, libappindicator-gtk3
, librsvg
, libsoup_3
, makeWrapper
, nodejs
, opencode
, openssl
, pkg-config
, rustPlatform
, rustc
, stdenvNoCC
, webkitgtk_4_1
, wrapGAppsHook4
, bubblewrap
, bash
, uv
}:

let
  gtk = gtk3;
  libappindicator-gtk = libappindicator-gtk3;
  libsoup = libsoup_3;
  webkitgtk = webkitgtk_4_1;
  #rosandboxwrap = baseName: innerCommand: (writeShellScriptBin baseName ''
  #  exec bwrap \
  #    --unshare-pid \
  #    --unshare-uts \
  #    --unshare-cgroup \
  #    --ro-bind / / \
  #    --tmpfs /tmp \
  #    --proc /proc \
  #    --dev /dev \
  #    --bind $HOME/Documents/Sandbox $HOME \
  #    --ro-bind $HOME/.nix-profile $HOME/.nix-profile \
  #    ${innerCommand}
  #'' );
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "opencode-desktop";
  inherit (opencode)
    version
    src
    node_modules
    patches
    ;

  cargoRoot = "packages/desktop/src-tauri";
  cargoHash = "sha256-WI48iYdxmizF1YgOQtk05dvrBEMqFjHP9s3+zBFAat0=";
  buildAndTestSubdir = finalAttrs.cargoRoot;

  nativeBuildInputs = [
    pkg-config
    cargo-tauri.hook
    bun
    nodejs # for patchShebangs node_modules
    cargo
    rustc
    jq
    makeWrapper
  ]
  ++ lib.optionals stdenvNoCC.hostPlatform.isLinux [ wrapGAppsHook4 ];

  buildInputs = (
    lib.optionals stdenvNoCC.isLinux [
      dbus
      glib
      glib-networking
      gtk
      libappindicator-gtk
      librsvg
      libsoup
      openssl
      webkitgtk
    ]
    ++ (with gst_all_1; [
      gst-plugins-bad # fakevideosink
      gst-plugins-base # appsink and autoaudiosink
      gst-plugins-good # autoaudiosink
    ])
  );

  tauriBuildFlags = [
    "--config"
    "tauri.conf.json"
    "--config"
    "tauri.prod.conf.json"
    "--no-sign"
  ];

  preBuild = ''
    cp -a ${finalAttrs.node_modules}/{node_modules,packages} .
    chmod -R u+w node_modules packages
    patchShebangs node_modules packages/desktop/node_modules
    install -D ${lib.getExe opencode} \
      packages/desktop/src-tauri/sidecars/opencode-cli-${stdenvNoCC.hostPlatform.rust.rustcTarget}
  '';

  postFixup = ''
    mv $out/bin/OpenCode $out/bin/.OpenCode-wrapped-2
    echo '#!${bash}/bin/bash' > $out/bin/OpenCode
    echo 'exec ${bubblewrap}/bin/bwrap \' >> $out/bin/OpenCode
    echo '    --unshare-pid --unshare-uts --unshare-cgroup \' >> $out/bin/OpenCode
    echo '    --argv0 OpenCode \' >> $out/bin/OpenCode
    echo '    --setenv PATH ${lib.makeBinPath [ uv ]}:$PATH \' >> $out/bin/OpenCode
    echo '    --ro-bind / / \' >> $out/bin/OpenCode
    echo '    --tmpfs /tmp --proc /proc --dev /dev \' >> $out/bin/OpenCode
    echo '    --bind $HOME/Documents/Sandbox $HOME \' >> $out/bin/OpenCode
    echo '    --ro-bind $HOME/.nix-profile $HOME/.nix-profile \' >> $out/bin/OpenCode
    echo "    $out/bin/.OpenCode-wrapped-2" >> $out/bin/OpenCode
    chmod +x $out/bin/OpenCode

    #mv $out/bin/opencode-cli $out/bin/.opencode-cli-wrapped-2
    #echo '#!${bash}/bin/bash' > $out/bin/opencode-cli
    #echo 'exec ${bubblewrap}/bin/bwrap \' >> $out/bin/opencode-cli
    #echo '    --unshare-pid --unshare-uts --unshare-cgroup \' >> $out/bin/opencode-cli
    #echo '    --argv0 opencode-cli \' >> $out/bin/opencode-cli
    #echo '    --ro-bind / / \' >> $out/bin/opencode-cli
    #echo '    --tmpfs /tmp --proc /proc --dev /dev \' >> $out/bin/opencode-cli
    #echo '    --bind $HOME/Documents/Sandbox $HOME \' >> $out/bin/opencode-cli
    #echo '    --ro-bind $HOME/.nix-profile $HOME/.nix-profile \' >> $out/bin/opencode-cli
    #echo "    $out/bin/.opencode-cli-wrapped-2" >> $out/bin/opencode-cli
    #chmod +x $out/bin/opencode-cli
  '';

  meta = {
    description = "AI coding agent desktop client";
    homepage = "https://opencode.ai";
    inherit (opencode.meta) platforms;
    license = lib.licenses.mit;
    mainProgram = "OpenCode";
    maintainers = with lib.maintainers; [ xiaoxiangmoe ];
  };
})
