{ pkgs, ... }:
{
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  hardware.graphics = with pkgs; {
    extraPackages = [ intel-media-driver ];
    extraPackages32 = [ driversi686Linux.intel-media-driver ];
  };
}
