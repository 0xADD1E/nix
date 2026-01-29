final: prev: {
  # Kdenlive's python plugins require use of a venv
  # However, without a FHS wrapper, nix python isn't able to load libcxx
  kdenlive-plugin-compatible = (final.buildFHSEnv {
    name = "kdenlive";
    runScript = "kdenlive";
    targetPkgs = pkgs: [
      pkgs.kdePackages.kdenlive
      (pkgs.python313.withPackages (ps: [
        #ps.openai-whisper # This actually gets installed in the venv anyway
      ]))
    ];
    extraInstallCommands = ''
      # Bring over .desktop file, icons, etc
      ln -s ${prev.kdePackages.kdenlive}/share $out/share
    '';
  });
}
