{ pkgs, ... }:
{
  hardware = {
    # Enable all the firmware
    enableAllFirmware = true;

    # Enable all the firmware with a license allowing redistribution
    # (i.e. free firmware and firmware-linux-nonfree)
    enableRedistributableFirmware = true;
    sane = {
      enable = true;
      extraBackends = with pkgs; [
        sane-airscan
        hplipWithPlugin
      ];
      netConf = "172.16.1.2";
    };
  };

  services.fwupd.enable = true;

  services.fstrim.enable = true;
}
