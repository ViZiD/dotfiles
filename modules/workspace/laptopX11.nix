{ pkgs, ... }: {
  home-manager.users.radik.home.packages = with pkgs; [
    xclip
    feh
  ];

  programs.light.enable = true;
}
