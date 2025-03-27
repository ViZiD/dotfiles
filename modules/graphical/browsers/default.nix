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

  browser = [ "chromium.desktop" ];
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
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      programs = {
        chromium = {
          enable = true;
          package = pkgs.chromium;
          extensions = [
            { id = "mgijmajocgfcbeboacabfgobmjgjcoja"; } # Google Dictionary
            { id = "bgnkhhnnamicmpeenaelnjfhikgbkllg"; } # AdGuard AdBlocker
            { id = "neibhohkbmfjninidnaoacabkjonbahn"; } # Hide Google AI Overviews
            { id = "ldpochfccmkkmhdbclfhpagapcfdljkj"; } # Decentraleyes
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
            { id = "doojmbjmlfjjnbmnoijecmcbfeoakpjm"; } # NoScript
            { id = "ammjkodgmmoknidbanneddgankgfejfh"; } # 7TV
            { id = "bhlhnicpbhignbdhedgjhgdocnmhomnp"; } # ColorZilla
            { id = "cofdbpoegempjloogbagkncekinflcnj"; } # DeepL
            { id = "ghbmnnjooekpmoecnnnilnnbdlolhkhi"; } # Google Docs Offline
            { id = "mmioliijnhnoblpgimnlajmefafdfilb"; } # Shazam
            { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium
            { id = "abpdnfjocnmdomablahdcfnoggeeiedb"; } # Save All Resources
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
