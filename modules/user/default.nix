{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.dots.user;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  imports = [
    ./email.nix
    ./xdg.nix
  ];

  options.dots.user = {
    enable = mkEnableOption "Enable my user";
    askSudoPass = mkEnableOption "Ask sudo password";
    uid = mkOption {
      type = types.nullOr types.int;
      default = 1000;
      description = "My user uid";
    };
    email = mkOption {
      type = types.str;
      default = "mail@vizqq.cc";
      description = "My email";
    };
    username = mkOption {
      type = types.str;
      default = "radik";
      description = "My username";
    };
    realName = mkOption {
      type = types.str;
      default = "Radik Islamov";
      description = "My realname";
    };
    extraGroups = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    signingKey = mkOption {
      type = types.str;
      default = "F39646E80C7108E7";
      description = "Signing key";
    };
    trustedKey = mkOption {
      type = types.either types.path types.str;
      default = "";
      description = "Master trusted key";
    };
    authorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAxADjBmQT2x1NTfq9rjhgQgOA6RikfWWiznVpo5RH1e"
      ];
    };
    userPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Packages to be installed for my user";
    };
    extraHomeOptions = mkOption {
      type = types.attrsOf types.anything;
      description = "Extra home-manager options";
      default = { };
    };
    systemPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Packages to be installed on the systems";
    };
    rootPasswordFile = mkOption {
      default = config.age.secrets.rootPass.path;
      description = "Age file to include to use as root password";
    };
    userPasswordFile = mkOption {
      default = config.age.secrets.userPass.path;
      description = "Age file to include to use as user password";
    };
    setEmptyPassword = lib.mkEnableOption "If disabled, it will set a user password which requires agenix set up.";
    setEmptyRootPassword = lib.mkEnableOption "If disabled, it will set a root password which requires agenix set up.";
  };

  config = {
    users.mutableUsers = false;

    users.users.${cfg.username} = mkIf cfg.enable {
      inherit (cfg) uid;
      description = "${cfg.realName}";
      isNormalUser = true;
      extraGroups = [ "wheel" ] ++ (ifTheyExist cfg.extraGroups);
      hashedPasswordFile = mkIf (!cfg.setEmptyPassword) cfg.userPasswordFile;
      openssh.authorizedKeys.keys = cfg.authorizedKeys;
    };

    users.users.root = {
      hashedPasswordFile = mkIf (!cfg.setEmptyRootPassword) cfg.rootPasswordFile;
      openssh.authorizedKeys.keys = cfg.authorizedKeys;
    };

    environment.systemPackages = cfg.systemPackages;

    home-manager.users = mkIf cfg.enable {
      ${cfg.username} = mkMerge [
        {
          home.packages = cfg.userPackages;
        }
        cfg.extraHomeOptions
      ];
    };

    security.sudo = {
      wheelNeedsPassword = cfg.askSudoPass;
      extraConfig = mkIf isPersistEnabled ''
        # rollback results in sudo lectures after each reboot
        Defaults lecture = never
      '';
    };

    nix.settings.trusted-users = [
      "root"
    ] ++ optionals cfg.enable [ cfg.username ];
  };
}
