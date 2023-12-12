{ pkgs, ... }: {
  home-manager.users.radik.home.packages = with pkgs; [
    gnome.file-roller
  ];
}
