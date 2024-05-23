{ pkgs, ... }:
{
  home-manager.users.radik = {
    programs.helix = {
      enable = true;
      extraPackages = with pkgs; [
        clang-tools
        nixfmt-rfc-style
        dart
        java-language-server
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
      ];
      settings = {
        theme = "monokai";
        editor = {
          cursor-shape = {
            insert = "bar";
          };
        };
      };
      languages = {
        language-server.emmet-lsp = with pkgs; {
          command = "${emmet-language-server}/bin/emmet-language-server";
          args = [ "--stdio" ];
        };
        language = [
          {
            name = "html";
            roots = [ ".git" ];
            language-servers = [ "emmet-lsp" ];
          }
          {
            name = "json";
            auto-format = true;
          }
          {
            name = "css";
            auto-format = true;
          }
          {
            name = "html";
            auto-format = true;
          }
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
