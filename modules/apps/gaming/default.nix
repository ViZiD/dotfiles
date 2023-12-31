{ pkgs, config, ... }: {
  home-manager.users.radik = {
    home.packages = with pkgs; [
      config.nur.repos.materus.polymc
      steamguard-cli
      steam
    ];
  };
}
