{
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      tapping = false;
      tappingButtonMap = "lmr";
      clickMethod = "clickfinger";
      disableWhileTyping = true;
      scrollMethod = "twofinger";
      naturalScrolling = true;
    };
  };
}
