{ pkgs, ... }:
{
  home-manager.users.radik = {
    programs.helix = {
      enable = true;
      extraPackages = with pkgs; [ nixfmt-rfc-style ];
      settings = {
        theme = "monokai";
        editor = {
          cursor-shape = {
            insert = "bar";
          };
        };
      };
      languages = {
        language = [
          {
            name = "typescript";
            auto-format = true;
          }
          {
            name = "javascript";
            auto-format = true;
          }
          {
            name = "nix";
            formatter.command = "nixfmt";
            auto-format = true;
          }
        ];
      };
    };
  };
}
