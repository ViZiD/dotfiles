{
  security = {
    # Whether users of the wheel group must provide a
    # password to run commands as super user via sudo
    sudo = {
      wheelNeedsPassword = false;
    };

    # Enable the AppArmor Mandatory Access Control system
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };
}
