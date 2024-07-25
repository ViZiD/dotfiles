{ pkgs, ... }:
{
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
  };
  hardware.graphics = with pkgs; {
    extraPackages = [ intel-vaapi-driver ];
    extraPackages32 = [ pkgsi686Linux.intel-vaapi-driver ];
  };
}
