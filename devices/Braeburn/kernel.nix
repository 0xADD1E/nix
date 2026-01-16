{ lib
, callPackage
, linuxPackagesFor
, _kernelPatches ? [ ]
,
}:

let
  linux-asahi-pkg =
    { stdenv
    , lib
    , fetchFromGitHub
    , buildLinux
    , ...
    }:
    buildLinux rec {
      inherit stdenv lib;

      pname = "linux-asahi";
      version = "6.18.5-fairydust20260116";
      modDirVersion = "6.18.5";
      extraMeta.branch = "6.18";

      src = fetchFromGitHub {
        owner = "AsahiLinux";
        repo = "linux";
        # Current tip of branch fairydust https://github.com/AsahiLinux/linux/commits/fairydust/
        # Note for browsing: MBA M2 13in is t8112-j413
        rev = "fada65930a9b429d646eb2f384deb61896233284";
        hash = "sha256-Fs20sODkF4bsChqn0nHisei1ddXH99DgdHqogZSPvsI=";
      };

      kernelPatches = [
        {
          name = "Asahi config";
          patch = null;
          structuredExtraConfig = with lib.kernel; {
            # Needed for GPU
            ARM64_16K_PAGES = yes;

            ARM64_MEMORY_MODEL_CONTROL = yes;
            ARM64_ACTLR_STATE = yes;

            # Might lead to the machine rebooting if not loaded soon enough
            APPLE_WATCHDOG = yes;

            # Can not be built as a module, defaults to no
            APPLE_M1_CPU_PMU = yes;

            # Defaults to 'y', but we want to allow the user to set options in modprobe.d
            HID_APPLE = module;

            APPLE_PMGR_MISC = yes;
            APPLE_PMGR_PWRSTATE = yes;
          };
          features.rust = true;
        }
      ]
      ++ _kernelPatches;
    };

  linux-asahi = callPackage linux-asahi-pkg { };
in
lib.recurseIntoAttrs (linuxPackagesFor linux-asahi)
