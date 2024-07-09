{ pkgs, ... }:
{
  home-manager.users.radik = {
    home.packages = with pkgs; [
      tio
      difftastic
      inetutils
      tcpdump
      nettools
    ];
  };
}
