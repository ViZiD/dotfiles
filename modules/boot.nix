{
  boot = {
    kernelParams = [ "quiet"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
