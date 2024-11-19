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
        extraPackages = with pkgs; [
          clang-tools
          nixfmt-rfc-style
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted
          python311Packages.python-lsp-server
          emmet-language-server
          nixd
        ];
        settings = {
          theme = mkIf (!isStylesEnabled) "monokai";
          editor = {
            color-modes = true;
            cursorline = true;
            bufferline = "multiple";

            soft-wrap.enable = true;

            auto-save = {
              focus-lost = true;
              after-delay.enable = true;
            };
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
              right = [
                "diagnostics"
                "selections"
                "register"
                "file-type"
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
          ];
        };
      };
    };
  };
}
