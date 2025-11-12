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
    ./mic-fix.nix
  ];

  dots = {
    stateVersion = "25.05";
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
        # ventoy-full # FIXME: insecure
        parted

        # media
        asciinema
        inkscape

        # android
        apkleaks
        apkid
        apkeep
        apktool
        # mitm
        mitmproxy
        frida-tools

        ncftp

        # smartcard tool
        openpgp-card-tools

        # games
        shattered-pixel-dungeon

        ventoy-full
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

        usbutils

        nmap

        ntfs3g
      ];
      extraGroups = [
        "video"
        "audio"
        "jackaudio"
        "network"
        "input"
        "scanner"
        "lp"
        "lpadmin"
        # access to the serial and USB ports
        "dialout"

        # grant access to Android Debug Bridge (ADB)
        "adbusers"

        "vboxusers"
        "docker"
        "render"
        "wireshark"
      ];
      extraHomeOptions = {
        programs.mpv.config = lib.mkIf config.dots.graphical.enable {
          profile = "fast";
        };
      };
    };
    base.nix = {
      autoGC = true;
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
      lazygit.enable = true;
      direnv.enable = true;
      nix-index.enable = true;
      pass.enable = true;
      yazi.enable = true;
    };
    shared = {
      quietboot.enable = true;
      wireless.enable = true;
      sound.enable = true;
      laptopLid.enable = true;
      android.enable = true;
      bluetooth.enable = true;
      printing.enable = true;
      zapret.enable = false;
      vpn.enable = false;
      wireguard.enable = true;
      doh.enable = false;
      diff.enable = true;
      kdeconnect.enable = true;
      virt.enable = true;
      persist = {
        enable = true;
        user = {
          directories = [
            "projects"
            ".local/share/.shatteredpixel/shattered-pixel-dungeon"
          ];
        };
      };
    };
    graphical.enable = true;
    styles.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  programs.nix-ld.enable = true;

  vaultix.settings.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwesrYvUtKCt1asJgfk+4wTbg6Q//qz8caHPd/GywNK";

  security.polkit.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking = {
    interfaces = {
      enp0s25 = {
        useDHCP = true;
        ipv4.addresses = [
          {
            address = "192.168.88.2";
            prefixLength = 24;
          }
          # {
          #   address = "192.168.1.2";
          #   prefixLength = 24;
          # }
        ];
      };
    };
    hostName = lib.mkDefault hostname;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        8080
        80
      ];
    };
  };
}
