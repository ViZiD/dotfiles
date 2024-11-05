{
  lib,
  hostname,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  dots = {
    stateVersion = "24.11";
    user = {
      enable = true;
      xdg.enable = true;
      mail.enable = true;
      trustedKey = ./pgp.asc;
      userPackages = with pkgs; [
        # nix
        nix-init
        nix-tree
        nixfmt-rfc-style
        nix-update

        # misc
        tio
        difftastic
        inetutils
        tcpdump
        nettools
        csvlens
        ventoy-full
        parted

        # media
        ffmpeg-full
        yt-dlp
        asciinema

        # android
        apkleaks
        apkid
        apkeep
        apktool
        # mitm
        mitmproxy
        frida-tools
      ];
      systemPackages = with pkgs; [
        # compression
        zlib
        zip
        unzip
        bzip2
        zstd
        unrar
        p7zip
        atool
      ];
      extraGroups = [
        "video"
        "audio"
        "jackaudio"
        "network"
        "input"
        "scanner"
        "lp"

        # access to the serial and USB ports
        "dialout"

        # grant access to Android Debug Bridge (ADB)
        "adbusers"

        "vboxusers"
        "docker"
        "render"
      ];
    };
    dev.enable = true;
    cli = {
      gpg = {
        enable = true;
        smartCardsFeature = true;
        sshSupport = true;
        pinentryPackage = if config.dots.graphical.enable then pkgs.pinentry-qt else pkgs.pinentry-tty;
      };
      git.enable = true;
      gitui.enable = true;
      direnv.enable = true;
      nix-index.enable = true;
    };
    shared = {
      quietboot.enable = true;
      wireless.enable = true;
      sound.enable = true;
      laptopLid.enable = true;
      android.enable = true;
      bluetooth.enable = true;
      printing.enable = true;
      zapret.enable = true;
      # wireguard.enable = true;
      persist = {
        enable = true;
        user = {
          directories = [ "projects" ];
        };
      };
    };
    graphical.enable = true;
    styles.enable = true;
  };

  age = {
    rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwesrYvUtKCt1asJgfk+4wTbg6Q//qz8caHPd/GywNK";
  };

  security.polkit.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = lib.mkDefault hostname;
}
