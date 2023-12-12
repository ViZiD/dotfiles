{ lib, ... }:

{
  time.timeZone = "Asia/Yekaterinburg";

  console = {
    font = "cyr-sun16";
    keyMap = "ruwin_alt_sh-UTF-8";
  };

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];

  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "us,ru";
    XKB_DEFAULT_OPTIONS = "grp:alt_shift_toggle";
    LANG = lib.mkForce "en_US.UTF-8";
  };

  home-manager.users.radik = {
    home.language =
      let
        en = "en_US.UTF-8";
        ru = "ru_RU.UTF-8";
      in
      {
        address = ru;
        monetary = ru;
        paper = ru;
        time = en;
        base = en;
      };
  };
}
