{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.brave;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.brave.enable = mkEnableOption "Enable brave browser";

  config = mkIf cfg.enable {
    stylix.targets = mkIf isStylesEnabled { chromium.enable = true; };
    dots.shared.persist.user = mkIf (user.enable && isPersistEnabled) {
      directories = [
        ".config/BraveSoftware"
      ];
    };
    home-manager.users.${user.username} = mkIf user.enable {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
          { id = "mgijmajocgfcbeboacabfgobmjgjcoja"; } # Google Dictionary
          { id = "bgnkhhnnamicmpeenaelnjfhikgbkllg"; } # AdGuard AdBlocker
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
          # use the plain text store
          "--password-store=basic"
        ];
      };
    };
  };
}
