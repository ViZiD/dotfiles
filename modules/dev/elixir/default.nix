{ pkgs, ... }: {
  home-manager.users.radik = {
    home.packages = with pkgs; [
      elixir
      elixir-ls

      gigalixir
    ];
  };
}
