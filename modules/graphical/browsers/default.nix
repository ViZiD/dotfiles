{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.browsers;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.browsers.enable = mkEnableOption "Enable browsers packages";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
        ".mozilla"
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { firefox.enable = true; };
      home.packages = with pkgs; [
      ];
      programs.firefox = {
        enable = true;
        profiles.default = {
          settings = {
            # make browser more pindosian
            distribution.searchplugins.defaultLocale = "en-US";
            browser.search.countryCode = "US";
            browser.search.region = "US";
            general.useragent.locale = "en-US";
            general.smoothScroll = false;

            extensions.autoDisableScopes = 0;
            extensions.update.enabled = false;
            extensions.systemAddon.update.enabled = false;
          };
          search = {
            engines = {
              "Nix" = {
                urls = [
                  {
                    template = "https://mynixos.com/search";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nix" ];
              };
              "Github" = {
                urls = [
                  {
                    template = "https://github.com/search";
                    params = [
                      {
                        name = "type";
                        value = "repositories";
                      }
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                definedAliases = [ "@gh" ];
              };
              "Github User" = {
                urls = [
                  {
                    template = "https://github.com/search";
                    params = [
                      {
                        name = "type";
                        value = "users";
                      }
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];

                definedAliases = [ "@ghu" ];
              };
            };
            force = true;
          };
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            sponsorblock
            pkgs.nur.repos.rycee.firefox-addons."7tv"
            vimium
            translate-web-pages
          ];
        };
      };
      xdg.mimeApps.defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}
