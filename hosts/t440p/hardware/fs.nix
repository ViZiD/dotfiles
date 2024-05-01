{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cbe3c413-c8bd-4168-90d3-f7ea592b3c4e";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/748E-9AAA";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/9ac545a1-8519-4a9b-8422-0be19f15f53e"; } ];
}
