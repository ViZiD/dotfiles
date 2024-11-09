# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "sd_mod"
    "sr_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # fileSystems."/" = {
  #   device = "/dev/disk/by-uuid/cbe3c413-c8bd-4168-90d3-f7ea592b3c4e";
  #   fsType = "ext4";
  # };

  # boot.initrd.luks.devices."luks-fcd9a6bb-9d5b-4ec4-b88c-672b9f43fd35".device = "/dev/disk/by-uuid/fcd9a6bb-9d5b-4ec4-b88c-672b9f43fd35";

  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-uuid/748E-9AAA";
  #   fsType = "vfat";
  #   options = [
  #     "fmask=0022"
  #     "dmask=0022"
  #   ];
  # };

  # swapDevices = [
  #   { device = "/dev/disk/by-uuid/9ac545a1-8519-4a9b-8422-0be19f15f53e"; }
  # ];

  boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
    mkdir -p /mnt

    mount -o subvol=/ /dev/mapper/enc /mnt

    btrfs subvolume list -o /mnt/root |
    cut -f9 -d' ' |
    while read subvolume; do
      echo "deleting /$subvolume subvolume..."
      btrfs subvolume delete "/mnt/$subvolume"
    done &&
    echo "deleting /root subvolume..." &&
    btrfs subvolume delete /mnt/root

    echo "restoring blank /root subvolume..."
    btrfs subvolume snapshot /mnt/root-blank /mnt/root

    umount /mnt
  '';

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/113b5dbf-7245-48a5-b7c0-342c57d58312";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/e92959ee-6265-4de2-80bb-bdcf87e5f5d2";

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/113b5dbf-7245-48a5-b7c0-342c57d58312";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/113b5dbf-7245-48a5-b7c0-342c57d58312";
    neededForBoot = true;
    fsType = "btrfs";
    options = [ "subvol=persist" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/825A-3F02";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/ec040e4c-0756-4d80-9b4e-b7b68a35664d"; } ];

  networking.useDHCP = lib.mkDefault true;

  nix.settings.max-jobs = lib.mkDefault 2;

  services.fwupd.enable = true;

  services.fstrim.enable = true;

  hardware.enableRedistributableFirmware = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.thinkfan = {
    enable = true;
    levels = [
      [
        0
        0
        50
      ]
      [
        1
        50
        55
      ]
      [
        2
        55
        60
      ]
      [
        3
        60
        65
      ]
      [
        4
        65
        70
      ]
      [
        5
        70
        75
      ]
      [
        6
        75
        80
      ]
      [
        7
        80
        85
      ]
      [
        "level disengaged"
        85
        99
      ]
    ];
  };
}