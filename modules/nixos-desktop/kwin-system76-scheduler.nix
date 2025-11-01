{ lib
, stdenv
, fetchFromGitHub
, kpackage
, kwin
, nodejs
,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "kwin-system76-scheduler-integration";
  version = "0.1-main-8375d843afbd2fe20780a79a473cabddbaff3602";

  src = fetchFromGitHub {
    owner = "maxiberta";
    repo = "kwin-system76-scheduler-integration";
    rev = "8375d843afbd2fe20780a79a473cabddbaff3602";
    hash = "";
  };

  postPatch = ''
    patchShebangs system76-scheduler-dbus-proxy.sh
  '';

  nativeBuildInputs = [
    kpackage
    nodejs
  ];
  buildInputs = [ kwin ];
  dontWrapQtApps = true;

  installPhase = ''
    runHook preInstall

    kpackagetool6 --type=KWin/Script --install=./package --packageroot=$out/share/kwin/scripts

    runHook postInstall
  '';

  meta = {
    description = "KWin Script for system76-scheduler Integration";
    homepage = "https://github.com/maxiberta/kwin-system76-scheduler-integration";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
})
