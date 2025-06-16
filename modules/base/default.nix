{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots;
  user = cfg.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  imports = [
    ./nix.nix
    ./zsh.nix
    ./helix.nix
    ./vim.nix
    ./htop.nix
    ./ssh.nix
  ];

  options.dots = {
    stateVersion = mkOption {
      type = types.str;
      example = "24.11";
      description = "The NixOS state version to use for this system";
    };
  };

  config = {
    dots.base = {
      nix.enable = true;
      zsh.enable = true;
      helix.enable = true;
      vim.enable = true;
      htop.enable = true;
      ssh.enable = true;
    };

    dots.shared.persist = mkIf isPersistEnabled {
      system = {
        directories = [
          "/etc/nixos"
        ];
      };
      user = mkIf user.enable {
        directories = [
          ".cache"
          ".config/sops" # for sops keys
        ];
      };
    };

    system.stateVersion = cfg.stateVersion;

    stylix.targets = mkIf isStylesEnabled {
      console.enable = true;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${user.username} = mkIf user.enable {

        stylix.targets = mkIf isStylesEnabled {
          bat.enable = true;
        };

        news.display = "silent"; # i hate mainstream media
        home = {
          stateVersion = cfg.stateVersion;
          language =
            let
              en = "en_US.UTF-8";
              ru = "ru_RU.UTF-8";
            in
            {
              address = ru;
              monetary = ru;
              paper = ru;
              time = en;
              base = en;
            };
        };
      };
    };

    home-manager.users.root.home.stateVersion = cfg.stateVersion;

    console = {
      font = "cyr-sun16";
      keyMap = "ruwin_alt_sh-UTF-8";
    };

    time.timeZone = "Asia/Yekaterinburg";

    i18n.supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ] ++ optionals (versionOlder config.nix.package.version "2.22.0") [ "repl-flake" ];

    environment.systemPackages = with pkgs; [
      eza
      bat
      tree
      dig
      fd
    ];
  };
}
