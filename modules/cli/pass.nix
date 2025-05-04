{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.pass;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.cli.pass.enable = mkEnableOption "Enable password manager";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages =
        with pkgs;
        with pkgs.nur.repos.vizqq;
        [
          age-plugin-fido2-hmac
          age-plugin-openpgp-card
          gopass
        ];
      # programs.password-store = {
      #   enable = true;
      #   package = pkgs.pass-wayland.withExtensions (
      #     p: with p; [
      #       pass-otp
      #       pass-audit
      #       pass-update
      #       pass-genphrase
      #     ]
      #   );
      #   settings = {
      #     PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
      #   };
      # };
    };
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".local/share/password-store"
        ".config/gopass"
      ];
    };
  };
}
