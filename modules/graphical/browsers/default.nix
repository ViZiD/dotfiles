{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.browser;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
  # isStylesEnabled = config.dots.styles.enable;
  hmConfig = config.home-manager.users.${user.username};
  quteTheme = import ./theme.nix {
    inherit config;
  };

  browser = [ "org.qutebrowser.qutebrowser.desktop" ];
  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;
  };

in
{
  options.dots.graphical.browser.enable = mkEnableOption "Enable browser";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
        ".config/chromium"
        ".local/share/qutebrowser"
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      systemd.user.services.qutebrowser-setup = {
        Unit = {
          Description = "Fetch qutebrowser dicts for my languages";
          After = [ "network-online.target" ];
          Wants = [ "network-online.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "qute-dict-install" (
            builtins.concatStringsSep "\n" (
              builtins.map (
                n: "${hmConfig.programs.qutebrowser.package}/share/qutebrowser/scripts/dictcli.py install ${n}"
              ) hmConfig.programs.qutebrowser.settings.spellcheck.languages
            )

          );
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
      programs = {
        qutebrowser = {
          enable = true;
          settings = {
            inherit (quteTheme) colors fonts;
            auto_save.session = true;
            url = {
              start_pages = [ "https://google.com" ];
              open_base_url = true;
              default_page = "https://google.com";
            };
            downloads = {
              location = {
                directory = "~/downloads";
                prompt = false;
              };
            };
            content = {
              autoplay = false;
              geolocation = false;
              javascript = {
                clipboard = "access";
              };
              notifications = {
                enabled = false;
              };
              register_protocol_handler = false;
            };
            confirm_quit = [
              "downloads"
            ];
            scrolling = {
              bar = "when-searching";
            };
            spellcheck.languages = [
              "ru-RU"
              "en-US"
            ];
            editor.command = [
              "${pkgs.kitty}/bin/kitty"
              "--class"
              "qute-editor"
              "-e"
              "hx"
              "{}"
            ];
            tabs = {
              show = "multiple";
              last_close = "startpage";
            };
            hints.radius = 0;
          };
          quickmarks = {
            "gh" = "github.com";
            "yt" = "youtube.com";
            "th" = "twitch.tv";
            "cg" = "codeberg.org";
            "sh" = "sr.ht";
            "gl" = "gmail.com";
            "pm" = "privateemail.com";
            "ra" = "rezka.fi";
            "dl" = "deepl.com/en/translator";
            "tgk" = "web.telegram.org/k";
            "tga" = "web.telegram.org/a";
          };
          searchEngines = {
            "DEFAULT" = "https://google.com/search?hl=en&q={}";
            "gg" = "https://google.com/search?hl=en&q={}";
            "ng" = "https://noogle.dev/q?term={}";
            "gnp" = "https://github.com/NixOS/nixpkgs/search?q={}";
            "gns" = "https://github.com/search?q={}+lang%3ANix&type=code";
            "nsp" = "https://search.nixos.org/packages?channel=unstable&query={}";
            "nso" = "https://search.nixos.org/options?channel=unstable&query={}";
            "mn" = "https://mynixos.com/search?q={}";
            "nw" = "https://nixos.wiki/index.php?search={}";
            "aw" = "https://wiki.archlinux.org/?search={}";
          };
          keyBindings = {
            normal = {
              # open clipboard item shortcuts
              "p" = "open -- {clipboard}";
              "P" = "open -t -- {clipboard}";
            };
          };
          greasemonkey = import ./scripts {
            inherit pkgs;
            colors = config.lib.stylix.colors.withHashtag;
          };
        };
        chromium = {
          enable = true;
          package = pkgs.chromium;
          extensions = [
            { id = "mgijmajocgfcbeboacabfgobmjgjcoja"; } # Google Dictionary
            { id = "bgnkhhnnamicmpeenaelnjfhikgbkllg"; } # AdGuard AdBlocker
            { id = "neibhohkbmfjninidnaoacabkjonbahn"; } # Hide Google AI Overviews
            { id = "ldpochfccmkkmhdbclfhpagapcfdljkj"; } # Decentraleyes
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
            { id = "ammjkodgmmoknidbanneddgankgfejfh"; } # 7TV
            { id = "bhlhnicpbhignbdhedgjhgdocnmhomnp"; } # ColorZilla
            { id = "cofdbpoegempjloogbagkncekinflcnj"; } # DeepL
            { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # Google Docs Offline
            { id = "mmioliijnhnoblpgimnlajmefafdfilb"; } # Shazam
            { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium
            { id = "abpdnfjocnmdomablahdcfnoggeeiedb"; } # Save All Resources
            { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; } # Tampermonkey
          ];
          commandLineArgs = [
            "--disable-features=WebRtcAllowInputVolumeAdjustment"
          ];
        };
      };
      xdg.mimeApps = {
        defaultApplications = associations;
        associations.added = associations;
      };
    };
  };
}
