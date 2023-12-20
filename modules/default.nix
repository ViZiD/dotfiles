{ flake-utils }:
let
  nixosModules = flake-utils.lib.exportModules [
    ./boot.nix
    ./home.nix
    ./locale.nix
    ./network.nix
    ./nix.nix
    ./system.nix
    ./security.nix
    ./services.nix
    ./hardware.nix
    ./sound.nix
    ./bluetooth.nix
    ./power.nix
    ./opengl.nix

    ./user
    ./user/physlock.nix

    ./dev

    ./apps
    ./apps/reading
    ./apps/monitoring
    ./apps/music
    ./apps/fm
    ./apps/gaming
    ./apps/tools
    ./apps/terminal
    ./apps/messaging
    ./apps/editor
    ./apps/web
    ./apps/electronics

    ./apps/security/gpg.nix

    ./apps/security/pass.nix

    ./apps/scm/git.nix
    ./apps/shell/zsh.nix

    ./xwindow
    ./xwindow/xserver/libinput.nix

    ./workspace
    ./workspace/cursor.nix
    ./workspace/laptopX11.nix
    ./workspace/gtk.nix

    ./workspace/bspwm
    ./workspace/gnome

    ./themes.nix
  ];
  base = with nixosModules; [
    boot
    home
    locale
    network
    nix
    system
    security
    services
    user

    zsh
    git
  ];

  desktop = with nixosModules; [
    power
    hardware
    sound
    bluetooth
    opengl

    themes

    physlock

    gnome
    workspace
    cursor
    gtk

    dev
    apps
    reading
    monitoring
    music
    fm
    tools
    editor
    web
    messaging
    terminal
    # electronics

    gpg
    pass
  ];

  desktop-bspwm = with nixosModules; [
    bspwm

    xwindow
    libinput

    laptopX11

    gaming
  ] ++ desktop;
in
{
  inherit nixosModules base desktop-bspwm;
}

