{ config, lib, ... }:
let
  enableGpg = config.home-manager.users.radik.programs.gpg.enable;
in
with lib;
{
  home-manager.users.radik = {
    programs.git = {
      enable = true;
      userEmail = "vizid1337@gmail.com";
      userName = "Radik Islamov";
      ignores = [ "venv" ".env" "node_modules" "shell.nix" ".envrc" ".direnv" ];
      extraConfig = {
        init.defaultBranch = "master";
        pull.rebase = true;
        rebase.autoStash = true;
        http.postBuffer = 1048576000;
        credential.helper = "store";
      };
      extraConfig.commit.gpgsign = mkIf enableGpg true;
      signing = mkIf enableGpg {
        signByDefault = true;
        key = "01F512CDD56A3DF7";
      };
    };
  };
}
