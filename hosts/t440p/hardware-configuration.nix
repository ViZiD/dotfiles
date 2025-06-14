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
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "nowatchdog"
    "kernel.nmi_watchdog=0"
    "msr.allow_writes=on"
    "snd_hda_codec_hdmi"
    "snd_hda_intel.power_save=1"
  ];
  boot.extraModprobeConfig = "options iwlwifi bt_coex_active=N"; # try fix headphones

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

  nix.settings.max-jobs = lib.mkDefault 4;

  services.fwupd.enable = true;

  services.fstrim.enable = true;

  hardware.enableRedistributableFirmware = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.graphics = {
    enable = true;
    extraPackages =
      with pkgs;
      lib.mkDefault [
        intel-vaapi-driver
        intel-compute-runtime
        libGL
        intel-ocl
        vpl-gpu-rt
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
        vulkan-tools
      ];
    extraPackages32 =
      with pkgs.pkgsi686Linux;
      lib.mkDefault [
        intel-vaapi-driver
      ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = lib.mkForce "i965";
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
