{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.base.helix;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.base.helix.enable = mkEnableOption "Enable helix editor";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled { helix.enable = true; };
      programs.helix = {
        enable = true;
        defaultEditor = true;
        extraPackages =
          with pkgs;
          with nodePackages;
          [
            bash-language-server

            # toml
            taplo
            taplo-lsp

            # toml
            yaml-language-server

            terraform-ls

            prettier
            typescript-language-server
            vscode-langservers-extracted

            python312Packages.python-lsp-server

            emmet-language-server

            nixfmt-rfc-style
            nixd
          ];
        settings = {
          theme = mkIf (!isStylesEnabled) "monokai";
          editor = {
            color-modes = true;
            cursorline = true;
            bufferline = "multiple";
            auto-info = true;

            soft-wrap.enable = true;

            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };

            lsp = {
              display-inlay-hints = true;
              display-messages = true;
            };

            statusline = {
              left = [
                "mode"
                "file-name"
                "spinner"
                "read-only-indicator"
                "file-modification-indicator"
              ];
              center = [
                "version-control"
                "file-name"
              ];
              right = [
                "diagnostics"
                "selections"
                "register"
                "file-type"
                "file-encoding"
                "file-line-ending"
                "position"
              ];
              mode = {
                normal = "N";
                insert = "I";
                select = "S";
              };
            };
          };
        };
        languages = {
          language-server = {
            emmet-lsp = {
              command = "emmet-language-server";
              args = [ "--stdio" ];
            };
            nixd = {
              command = "nixd";
            };
            yaml-language-server.config.yaml.schemas = {
              kubernetes = "k8s/*.yaml";
            };
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
              language-servers = [ "nixd" ];
              formatter.command = "nixfmt";
              auto-format = true;
            }
            {
              name = "python";
              auto-format = true;
            }
            {
              name = "yaml";
              language-servers = [ "yaml-language-server" ];
              formatter = {
                command = "prettier";
                args = [
                  "--stdin-filepath"
                  "file.yaml"
                ];
              };
              auto-format = true;
            }
          ];
        };
      };
    };
  };
}
