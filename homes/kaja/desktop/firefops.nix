{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;

    nativeMessagingHosts = with pkgs; [
      kdePackages.plasma-browser-integration
    ];

    policies = {
      # Updates
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      # Bloat Features
      DisableFirefoxStudies = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      GenerativeAI.Enabled = false;
      GenerativeAI.Locked = true;
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = false;
        MoreFromMozilla = false;
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      # We have 1Password for this
      OfferToSaveLogins = false;
      DisableFormHistory = true;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      ExtensionSettings = let moz = short: { install_url = "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi"; installation_mode = "force_installed"; }; in {
        "*".installation_mode = "blocked";
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = moz "1password-x-password-manager";
        "adnauseam@rednoise.org" = moz "adnauseam";
        "@axe-firefox-devtools" = moz "axe-devtools";
        "cliget@zaidabdulla.com" = moz "cliget";
        "sponsorBlocker@ajay.app" = moz "sponsorblock";
        "deArrow@ajay.app" = moz "dearrow";
        "gdpr@cavi.au.dk" = moz "consent-o-matic";
        "ff2mpv@yossarian.net" = moz "ff2mpv";
        "plasma-browser-integration@kde.org" = moz "plasma-integration";
        "@react-devtools" = moz "react-devtools";
        "{3c078156-979c-498b-8990-85f7987dd929}" = moz "sideberry";
        "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = moz "user-agent-string-switcher";
        "arc-dark-theme@afnankhan" = moz "arc-dark-theme-we";
      };
    };

    profiles.default = {
      #containers = {}; # maybe later
      extensions = {
        force = true;
        settings = {
          "adnauseam@rednoise.org".settings = {
            firstInstall = false;
            hidingAds = true;
            clickingAds = true;
            blockingMalware = true;
            disableClickingForDNT = true;
            selectedFilterLists = [
              "user-filters"
              "adnauseam-filters"
              "eff-dnt-whitelist"
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-unbreak"
              "ublock-quick-fixes"
              "easylist"
              "easyprivacy"
              "urlhaus-1"
            ];
          };
          "sponsorBlocker@ajay.app".settings = {
            alreadyInstalled = true;
          };
          "gdpr@cavi.au.dk".settings = { };
        };
      };

      search = {
        force = true;
        default = "kagi";
        engines = {
          kagi = {
            name = "Kagi";
            urls = [{
              template = "https://kagi.com/search";
              params = [{ name = "q"; value = "{searchTerms}"; }];
            }];
            iconMapObj."32" = "https://kagi.com/favicon-32x32.png";
            definedAliases = [ "@k" ];
          };
          nix-packages = {
            name = "Nix Packages";
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [ "@nw" ];
          };

          bing.metaData.hidden = true;
          google.metaData.hidden = true;
        };
      };
    };
  };
  # 1Password messaging host
  home.file.".mozilla/native-messaging-hosts/com.1password.1password.json".text = builtins.toJSON {
    name = "com.1password.1password";
    description = "1Password BrowserSupport";
    path = "/run/wrappers/bin/1Password-BrowserSupport";
    type = "stdio";
    allowed_extensions = [
      "{0a75d802-9aed-41e7-8daa-24c067386e82}"
      "{25fc87fa-4d31-4fee-b5c1-c32a7844c063}"
      "{d634138d-c276-4fc8-924b-40a0ea21d284}"
    ];
  };
}
