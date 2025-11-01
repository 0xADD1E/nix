{ kodi
, fetchzip
, ...
}:
# mkdir /home/user/.kodi/addons/plugin.program.akl/resources/
(kodi.override {
  gbmSupport = true;
}).withPackages (p: with p;[
  #trakt
  #upnext
  #a4ksubtitles

  #visualization-projectm
  #visualization-shadertoy

  #youtube
  #mediacccde
  #sponsorblock
  #bluetooth-manager
  #jellyfin #TODO: Sync Queue Plugin
  #invidious


  # TODO: Package from kodi addons
  # Aerial
  # Home-assistant
  # Android TV Sounds

  inputstream-adaptive
  # Steam Launcher
  (buildKodiAddon rec{
    # Horrible but don't @ me
    name = "kodi-distutils";
    namespace = "lib";
    src = kodi.pythonPackages.distutils;
    dontUnpack = true;
    installPhase = ''
      	  mkdir -p $out${addonDir}
      	  cp -r $src/lib $out${addonDir}/lib
      	'';
    passthru = {
      pythonPath = "python3.12/site-packages";
    };
  })
  (buildKodiAddon rec {
    pname = "lutris-kodi-addon";
    namespace = "plugin.lutris";
    version = "2.1.0";

    propagatedBuildInputs = [ routing plugin-cache ];
    src = fetchzip {
      url = "https://github.com/RobLoach/lutris-kodi-addon/archive/refs/tags/2.1.0.zip";
      sha256 = "sha256-l4qZY/T38PmFBQaUMlrTqAHRKVe6RhHmA2MfGfxoUwM=";
    };
  })
  #(buildKodiAddon rec {
  #  pname = "advanced-kodi-launcher";
  #  namespace = "plugin.program.akl";
  #  version = "1.5.3";
  #
  #  propagatedBuildInputs = [requests routing];
  #  src = fetchzip {
  #    url = "https://github.com/chrisism/repository.chrisism/raw/refs/heads/master/matrix/${namespace}/${namespace}-${version}.zip";
  #    sha256 = "sha256-a+451N2YsD2Kv/5TYsq5xx5eIuh0VcYiyLtcAg5N9n4=";
  #  };
  #  passthru = {
  #    pythonPath = "resources/lib";
  #  };
  #})
  #(buildKodiAddon rec {
  #  pname = "advanced-kodi-launcher-script";
  #  namespace = "script.module.akl";
  #  version = "1.2.1";
  #
  #  src = fetchzip {
  #    url = "https://github.com/chrisism/repository.chrisism/raw/refs/heads/master/matrix/${namespace}/${namespace}-${version}.zip";
  #    sha256 = "sha256-169rOMjyaVscg/ng3UtXrG7ohpA7vwlf3bO4TtdYCkE=";
  #  };
  #})
  #(buildKodiAddon rec {
  #  pname = "advanced-kodi-launcher-steam";
  #  namespace = "script.akl.steam";
  #  version = "1.1.1";
  #
  #  src = fetchzip {
  #    url = "https://github.com/chrisism/repository.chrisism/raw/refs/heads/master/matrix/${namespace}/${namespace}-${version}.zip";
  #    sha256 = "sha256-192rYORZDxaVbIrV6E+ai3HVR7En8OZbRGuK6obXzCI=";
  #  };
  #})
  #(buildKodiAddon rec {
  #  pname = "advanced-kodi-launcher-steamgriddb";
  #  namespace = "script.akl.steamgriddb";
  #  version = "1.1.1";
  #
  #  src = fetchzip {
  #    url = "https://github.com/chrisism/repository.chrisism/raw/refs/heads/master/matrix/${namespace}/${namespace}-${version}.zip";
  #    sha256 = "sha256-B7aOLvvepJyJhBqWp+oninboTqi8jjve5yKjjIUI04E=";
  #  };
  #})
])
