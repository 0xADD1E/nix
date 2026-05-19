{ lib, config, pkgs, ... }:
let
  aercDefaultBinds = {
    global = {
      "<C-p>" = ":prev-tab<Enter>";
      "<C-PgUp>" = ":prev-tab<Enter>";
      "<C-n>" = ":next-tab<Enter>";
      "<C-PgDn>" = ":next-tab<Enter>";
      "\\[t" = ":prev-tab<Enter>";
      "\\]t" = ":next-tab<Enter>";
      "<C-t>" = ":term<Enter>";
      "?" = ":help keys<Enter>";
      "<C-c>" = ":prompt 'Quit?' quit<Enter>";
      "<C-q>" = ":prompt 'Quit?' quit<Enter>";
      "<C-z>" = ":suspend<Enter>";
    };
    messages = {
      "j" = ":next<Enter>";
      "<Down>" = ":next<Enter>";
      "<C-d>" = ":next 50%<Enter>";
      "<C-f>" = ":next 100%<Enter>";
      "<PgDn>" = ":next 100%<Enter>";

      "k" = ":prev<Enter>";
      "<Up>" = ":prev<Enter>";
      "<C-u>" = ":prev 50%<Enter>";
      "<C-b>" = ":prev 100%<Enter>";
      "<PgUp>" = ":prev 100%<Enter>";
      "g" = ":select 0<Enter>";
      "G" = ":select -1<Enter>";

      "J" = ":next-folder<Enter>";
      "<C-Down>" = ":next-folder<Enter>";
      "K" = ":prev-folder<Enter>";
      "<C-Up>" = ":prev-folder<Enter>";
      "H" = ":collapse-folder<Enter>";
      "<C-Left>" = ":collapse-folder<Enter>";
      "L" = ":expand-folder<Enter>";
      "<C-Right>" = ":expand-folder<Enter>";

      "v" = ":mark -t<Enter>";
      "<Space>" = ":mark -t<Enter>:next<Enter>";
      "V" = ":mark -v<Enter>";

      "T" = ":toggle-threads<Enter>";
      "zc" = ":fold<Enter>";
      "zo" = ":unfold<Enter>";
      "za" = ":fold -t<Enter>";
      "zM" = ":fold -a<Enter>";
      "zR" = ":unfold -a<Enter>";
      "<tab>" = ":fold -t<Enter>";

      "zz" = ":align center<Enter>";
      "zt" = ":align top<Enter>";
      "zb" = ":align bottom<Enter>";

      "<Enter>" = ":view<Enter>";
      "d" = ":choose -o y 'Really delete this message' delete-message<Enter>";
      "D" = ":delete<Enter>";
      "a" = ":archive flat<Enter>";
      "A" = ":unmark -a<Enter>:mark -T<Enter>:archive flat<Enter>";

      "C" = ":compose<Enter>";
      "m" = ":compose<Enter>";

      "b" = ":bounce<space>";

      "rr" = ":reply -a<Enter>";
      "rq" = ":reply -aq<Enter>";
      "Rr" = ":reply<Enter>";
      "Rq" = ":reply -q<Enter>";

      "c" = ":cf<space>";
      "$" = ":term<space>";
      "!" = ":term<space>";
      "|" = ":pipe<space>";

      "/" = ":search<space>";
      "\\" = ":filter<space>";
      "n" = ":next-result<Enter>";
      "N" = ":prev-result<Enter>";
      "<Esc>" = ":clear<Enter>";

      "s" = ":split<Enter>";
      "S" = ":vsplit<Enter>";

      "pl" = ":patch list<Enter>";
      "pa" = ":patch apply <Tab>";
      "pd" = ":patch drop <Tab>";
      "pb" = ":patch rebase<Enter>";
      "pt" = ":patch term<Enter>";
      "ps" = ":patch switch <Tab>";
    };
    "messages:folder=Drafts" = {
      "<Enter>" = ":recall<Enter>";
    };
    view = {
      "/" = ":toggle-key-passthrough<Enter>/";
      "q" = ":close<Enter>";
      "O" = ":open<Enter>";
      "o" = ":open<Enter>";
      "S" = ":save<space>";
      "|" = ":pipe<space>";
      "D" = ":delete<Enter>";
      "A" = ":archive flat<Enter>";

      "<C-y>" = ":copy-link <space>";
      "<C-l>" = ":open-link <space>";

      "f" = ":forward<Enter>";
      "rr" = ":reply -a<Enter>";
      "rq" = ":reply -aq<Enter>";
      "Rr" = ":reply<Enter>";
      "Rq" = ":reply -q<Enter>";

      "H" = ":toggle-headers<Enter>";
      "<C-k>" = ":prev-part<Enter>";
      "<C-Up>" = ":prev-part<Enter>";
      "<C-j>" = ":next-part<Enter>";
      "<C-Down>" = ":next-part<Enter>";
      "J" = ":next<Enter>";
      "<C-Right>" = ":next<Enter>";
      "K" = ":prev<Enter>";
      "<C-Left>" = ":prev<Enter>";
    };
    "view::passthrough" = {
      "$noinherit" = "true";
      "$ex" = "<C-x>";
      "<Esc>" = ":toggle-key-passthrough<Enter>";
    };
    compose = {
      "$noinherit" = "true";
      "$ex" = "<C-x>";
      "$complete" = "<C-o>";
      "<C-k>" = ":prev-field<Enter>";
      "<C-Up>" = ":prev-field<Enter>";
      "<C-j>" = ":next-field<Enter>";
      "<C-Down>" = ":next-field<Enter>";
      "<A-p>" = ":switch-account -p<Enter>";
      "<C-Left>" = ":switch-account -p<Enter>";
      "<A-n>" = ":switch-account -n<Enter>";
      "<C-Right>" = ":switch-account -n<Enter>";
      "<tab>" = ":next-field<Enter>";
      "<backtab>" = ":prev-field<Enter>";
      "<C-p>" = ":prev-tab<Enter>";
      "<C-PgUp>" = ":prev-tab<Enter>";
      "<C-n>" = ":next-tab<Enter>";
      "<C-PgDn>" = ":next-tab<Enter>";
    };
    "compose::editor" = {
      "$noinherit" = "true";
      "$ex" = "<C-x>";
      "<C-k>" = ":prev-field<Enter>";
      "<C-Up>" = ":prev-field<Enter>";
      "<C-j>" = ":next-field<Enter>";
      "<C-Down>" = ":next-field<Enter>";
      "<C-p>" = ":prev-tab<Enter>";
      "<C-PgUp>" = ":prev-tab<Enter>";
      "<C-n>" = ":next-tab<Enter>";
      "<C-PgDn>" = ":next-tab<Enter>";
    };
    "compose::review" = {
      "y" = ":send<Enter> # Send";
      "n" = ":abort<Enter> # Abort (discard message, no confirmation)";
      "s" = ":sign<Enter> # Toggle signing";
      "x" = ":encrypt<Enter> # Toggle encryption to all recipients";
      "v" = ":preview<Enter> # Preview message";
      "p" = ":postpone<Enter> # Postpone";
      "q" = ":choose -o d discard abort -o p postpone postpone<Enter> # Abort or postpone";
      "e" = ":edit<Enter> # Edit (body and headers)";
      "a" = ":attach<space> # Add attachment";
      "d" = ":detach<space> # Remove attachment";
    };
    terminal = {
      "$noinherit" = "true";
      "$ex" = "<C-x>";

      "<C-p>" = ":prev-tab<Enter>";
      "<C-n>" = ":next-tab<Enter>";
      "<C-PgUp>" = ":prev-tab<Enter>";
      "<C-PgDn>" = ":next-tab<Enter>";
    };
  };
in
{
  programs.onepassword-secrets = {
    enable = lib.mkDefault true;
    secrets = {
      mailPersonalPassword = {
        reference = "op://opnix/Fastmail-0xadd1e.me/password";
        path = ".config/localmail/personal_password";
      };
    };
  };
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      #accountsOrder = [];
      #calendarAccountsOrder=[];
    };
  };

  programs.aerc = {
    enable = true;
    extraConfig = {
      general.unsafe-accounts-conf = true;
    };
    extraBinds = aercDefaultBinds // {
      messages = aercDefaultBinds.messages // {
        a = ":archive year<Enter>";
        A = ":unmark -a<Enter>:mark -T<Enter>:archive year<Enter>";
        d = ":choose -o y 'Really delete this message' move Trash<Enter>";
        D = ":move Trash<Enter>";
      };
      view = aercDefaultBinds.view // {
        D = ":move Trash<Enter>";
        A = ":archive year<Enter>";
      };
    };
  };
  programs.meli = { enable = true; };
  programs.neomutt = {
    enable = true;
    binds = [
      { map = [ "index" "pager" ]; key = "B"; action = "sidebar-toggle-visible"; }
      { map = [ "index" ]; key = "g"; action = "noop"; }
      { map = [ "index" ]; key = "gg"; action = "first-entry"; }
      { map = [ "index" ]; key = "G"; action = "last-entry"; }
      { map = [ "pager" ]; key = "j"; action = "next-line"; }
      { map = [ "pager" ]; key = "k"; action = "previous-line"; }
      { map = [ "editor" ]; key = "<Tab>"; action = "complete-query"; }
    ];
    macros = [
      { map = [ "index" ]; key = "A"; action = "<save-message>=Archive<enter>"; }
    ];
    sidebar = {
      enable = true;
      format = "%B%<F? [%F]>%* %<N?%N/>%S";
    };
    extraConfig = ''
      set mail_check_stats
      set mark_old = no
    '';
  };
  programs.notmuch = {
    enable = true;
  };
  programs.msmtp = {
    enable = true;
  };

  #Temporary while getting bits sorted
  programs.mbsync.enable = true;
  services.imapnotify.enable = false;
  services.mbsync.enable = false;

  accounts.email.accounts = {
    Personal = {
      enable = true;
      primary = true;

      realName = "Addison Morrison";
      signature = {
        showSignature = "append";
        text = ''
          Best wishes,
          Addison
        '';
      };

      flavor = "fastmail.com";
      folders.trash = "Archive";
      address = lib.strings.join "@" [ "me" "0xadd1e.me" ];
      passwordCommand = "cat ${config.programs.onepassword-secrets.secretPaths.mailPersonalPassword}";

      # Try out the neomutt/notmuch/msmtp/offlineimap world
      aerc = { enable = true; };
      meli = { enable = true; };
      neomutt = { enable = true; };
      notmuch = { enable = true; neomutt.enable = true; };
      msmtp = { enable = true; };
      mbsync = {
        enable = true;
        create = "maildir";
        #subFolders="Maildir++";
      };
      imapnotify = {
        enable = true;
        boxes = [ "INBOX" ];
        onNotify = "${config.programs.mbsync.package}/bin/mbsync Personal:INBOX && ${pkgs.notmuch}/bin/notmuch new";
        onNotifyPost = "${pkgs.libnotify}/bin/notify-send 'New mail arrived'";
      };

      # And more normal mail clients
      thunderbird = {
        enable = false;
        settings = id: {
          "mail.server.server_${id}.check_new_mail" = false;
        };
      };

    };
  };
}
