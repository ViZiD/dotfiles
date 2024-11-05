{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.cli.git;
  user = config.dots.user;
in
{
  options.dots.cli.git.enable = mkEnableOption "Enable git";
  config = mkIf cfg.enable {

    environment.systemPackages = [
      pkgs.git
    ];

    home-manager.users.${user.username}.programs.git = mkIf user.enable {
      enable = true;
      userEmail = "${user.email}";
      userName = "${user.realName}";
      ignores = [
        "result"
        ".direnv"
      ];
      aliases = {
        p = "pull --ff-only";
        ff = "merge --ff-only";
        graph = "log --decorate --oneline --graph";
        pushall = "!git remote | xargs -L1 git push --all";
      };
      extraConfig = {
        init.defaultBranch = "master";
        pull.rebase = true;
        rebase.autoStash = true;
        http.postBuffer = 524288000;
        credential.helper = "store";
        commit.gpgsign = true;

        merge.conflictStyle = "zdiff3";
        commit.verbose = true;
        diff.algorithm = "histogram";
        log.date = "iso";
        column.ui = "auto";
        branch.sort = "committerdate";
        push.autoSetupRemote = true;
        rerere.enabled = true;
      };
      signing = {
        signByDefault = true;
        key = "${user.signingKey}";
      };
    };
  };
}
