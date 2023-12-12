{
  services.xserver = {
    enable = true;
     # Symlink the X server configuration under /etc/X11/xorg.conf
    exportConfiguration = true;

    # Length of time in milliseconds that a key must be
    # depressed before autorepeat starts
    autoRepeatDelay = 200;

    # Length of time in milliseconds that should elapse between
    # autorepeat-generated keystrokes
    autoRepeatInterval = 40;

    layout = "us,ru";
    xkbModel = "pc105";
    xkbVariant = "qwerty";

    xkbOptions = "grp:alt_shift_toggle";

  };
}
