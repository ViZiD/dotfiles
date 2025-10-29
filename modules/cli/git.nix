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
      ignores = [
        "result"
        ".direnv"
        ".envrc"
        ".env"
      ];
      settings = {
        user = {
          email = "${user.email}";
          name = "${user.realName}";
        };

        alias = {
          p = "pull --ff-only";
          ff = "merge --ff-only";
          graph = "log --decorate --oneline --graph";
          pushall = "!git remote | xargs -L1 git push --all";
          cb = "switch -c";
          au = "remote add -f upstream";

          # some hacks for large repos
          # https://www.git-scm.com/docs/partial-clone
          au-promisor = "!git remote add upstream \"$@\" && shift \"$#\" && git fetch --filter=blob:none upstream";
          clone-promisor = "clone --filter=blob:none --no-checkout";
        };
        clone.filterSubmodules = true;

        init.defaultBranch = "master";

        url = {
          "git@github.com:".pushInsteadOf = "https://github.com/";
          "git@gist.github.com:".pushInsteadOf = "https://gist.github.com/";
          "git.debian.org:/git/".insteadOf = "https://anonscm.debian.org/git/";
          "git@salsa.debian.org:".insteadOf = "https://salsa.debian.org/";
        };

        http.postBuffer = 524288000;
        credential.helper = "store";
        commit.gpgsign = true;

        merge.conflictStyle = "zdiff3";
        merge.autoStash = true;
        rebase.autoStash = true;
        commit.verbose = true;

        diff.algorithm = "histogram";
        log.date = "iso";
        column.ui = "auto";
        branch.sort = "committerdate";
        # triangular workflow
        #
        # 1. clone your fork
        # 2. configure upstream using git au/au-promisor aliases, see above
        # 3. on branch createion branch off from upstream:
        #    `git cb <new_name> upstream/master`
        #
        # now you will push to origin and pull from upstream by default. this
        # makes it easier to stay in sync with upstream, while still pushing your
        # changes to origin
        push = {
          followtags = true;
          autoSetupRemote = true;
          default = "current";
        };

        remote.pushdefault = "origin";

        sequence.editor = "${pkgs.git-interactive-rebase-tool}/bin/interactive-rebase-tool";
      };
      signing = {
        signByDefault = true;
        key = "${user.signingKey}";
      };
    };
  };
}
