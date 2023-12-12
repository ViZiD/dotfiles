{
  services = {

    upower.enable = true;

    logind = {
      # What to be done when the laptop lid is closed
      lidSwitch = "suspend";
      # Pressing power button means hibernate
      extraConfig = "HandlePowerKey=hibernate";
    };
  };
}
