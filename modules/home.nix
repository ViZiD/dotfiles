{ config, ... }:
{
  environment.sessionVariables = config.home-manager.users.radik.home.sessionVariables // {
    NIX_AUTO_RUN = "1"; # means the program will be run via nix-shell.
    # (The grabage collector may remove it on the next GC run.)
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.radik = {
      news.display = "silent";

      systemd.user = {
        startServices = true;
      };

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      home.stateVersion = config.system.stateVersion;
    };
  };
}
