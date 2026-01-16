final: pref: {
  difftastic= (pref.difftastic.overrideAttrs(old: rec{
    buildInputs = [final.rust-jemalloc-sys];
  }));
}