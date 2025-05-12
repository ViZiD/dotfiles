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
            # docker
            dockerfile-language-server-nodejs
            docker-compose-language-service

            bash-language-server

            # markdown
            marksman

            # toml
            taplo
            taplo-lsp

            # toml
            yaml-language-server

            terraform-ls

            # web
            prettier
            typescript-language-server
            vscode-langservers-extracted
            emmet-language-server

            # python
            ruff
            (python3.withPackages (
              p:
              (with p; [
                python-lsp-ruff
                python-lsp-server
              ])
            ))

            # nix
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
              name = "dockerfile";
              scope = "source.dockerfile";
              injection-regex = "docker|dockerfile";
              roots = [
                "Dockerfile"
                "Containerfile"
              ];
              file-types = [
                "Dockerfile"
                { glob = "Dockerfile"; }
                { glob = "Dockerfile.*"; }
                "dockerfile"
                { glob = "dockerfile"; }
                { glob = "dockerfile.*"; }
                "Containerfile"
                { glob = "Containerfile"; }
                { glob = "Containerfile.*"; }
                "containerfile"
                { glob = "containerfile"; }
                { glob = "containerfile.*"; }
              ];
              comment-token = "#";
              indent = {
                tab-width = 2;
                unit = "  ";
              };
              language-servers = [ "docker-langserver" ];
            }
            {
              name = "docker-compose";
              scope = "source.yaml.docker-compose";
              roots = [
                "docker-compose.yaml"
                "docker-compose.yml"
              ];
              language-servers = [
                "docker-compose-langserver"
                "yaml-language-server"
              ];
              file-types = [
                { glob = "docker-compose.yaml"; }
                { glob = "docker-compose.yml"; }
              ];
              comment-token = "#";
              indent = {
                tab-width = 2;
                unit = "  ";
              };
            }
            {
              name = "html";
              roots = [ ".git" ];
              language-servers = [
                "emmet-lsp"
                "vscode-html-language-server"
              ];
              formatter = {
                command = "prettier";
                args = [
                  "--stdin-filepath"
                  "file.html"
                ];
              };
              auto-format = true;
            }
            {
              name = "tfvars";
              language-servers = [ "terraform-ls" ];
              formatter = {
                command = lib.getExe pkgs.terraform;
                args = [
                  "fmt"
                  "-"
                ];
              };
              auto-format = true;
            }
            {
              name = "hcl";
              language-servers = [ "terraform-ls" ];
              formatter = {
                command = lib.getExe pkgs.terraform;
                args = [
                  "fmt"
                  "-"
                ];
              };
              auto-format = true;
            }
            {
              name = "css";
              language-servers = [
                "emmet-lsp"
                "vscode-css-language-server"
              ];
              auto-format = true;
            }
            {
              name = "json";
              language-servers = [
                "vscode-css-language-server"
              ];
              auto-format = true;
            }
            {
              name = "jsonc";
              language-servers = [
                "vscode-css-language-server"
              ];
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
            {
              name = "toml";
              language-servers = [ "taplo" ];
              formatter = {
                command = "taplo";
                args = [
                  "fmt"
                  "-o"
                  "column_width=120"
                  "-"
                ];
              };
              auto-format = true;
            }
            {
              name = "markdown";
              language-servers = [
                "marksman"
              ];
              formatter = {
                command = "prettier";
                args = [
                  "--stdin-filepath"
                  "file.md"
                ];
              };
              comment-tokens = [
                "-"
                "+"
                "*"
                "- [ ]"
                ">"
              ];
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
              language-servers = [
                "pylsp"
              ];
              formatter = {
                command = "sh";
                args = [
                  "-c"
                  "ruff check --select I --fix - | ruff format --line-length 88 -"
                ];
              };
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
          ];
        };
      };
    };
  };
}
