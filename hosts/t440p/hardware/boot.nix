{
  boot = {
    initrd = {

      availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];

      luks.devices = {
        "luks-9cc52297-548f-495e-9810-05b809b6032a" = {
          device = "/dev/disk/by-uuid/9cc52297-548f-495e-9810-05b809b6032a";
          bypassWorkqueues = true;
        };
        "luks-fcd9a6bb-9d5b-4ec4-b88c-672b9f43fd35" = {
          device = "/dev/disk/by-uuid/fcd9a6bb-9d5b-4ec4-b88c-672b9f43fd35";
          bypassWorkqueues = true;
        };
      };

    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };
}
