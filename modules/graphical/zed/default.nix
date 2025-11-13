{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.graphical.zed;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.graphical.zed.enable = mkEnableOption "Enable zed editor";

  config = mkIf cfg.enable {

    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
      ];
    };

    home-manager.users.${user.username} = mkIf user.enable {

      stylix.targets = mkIf isStylesEnabled {
      };

      programs.zed-editor = {
        enable = true;
        # package = pkgs.inputs.zedless-editor.zed-editor;
        extensions = [
          "nix"
          "git-firefly"
          "dockerfile"
          "docker-compose"
          "toml"
          "zedokai"

          "ruff"
          "pylsp"
        ];
        extraPackages = with pkgs; [
          nixd
          nixfmt-rfc-style
          mypy
          python313Packages.python-lsp-server
          python313Packages.python-lsp-ruff
          python313Packages.pylsp-mypy
        ];
        userSettings = rec {
          auto_update = false;
          vim_mode = true;
          telemetry = {
            metrics = false;
            diagnostics = false;
          };

          file_types = {
            Dockerfile = [ "*Containerfile*" ];
          };

          load_direnv = "shell_hook";

          languages = {
            Nix = {
              language_servers = [
                "nixd"
                "!nil"
              ];
              formatter.external = {
                command = "${lib.getExe pkgs.nixfmt-rfc-style}";
                arguments = [
                  "--quiet"
                  "--"
                ];
              };
            };
            Python = {
              language_servers = [
                "!basedpyright"
                "ruff"
                "pylsp"
              ];
              format_on_save = "on";
              formatter = [
                {
                  language_server = {
                    name = "ruff";
                  };
                }
              ];
            };
          };
          lsp = {
            nixd = {
              binary.path = lib.getExe pkgs.nixd;
            };
            pylsp = {
              settings = {
                plugins = {
                  pycodestyle = {
                    enabled = false;
                  };
                  mypy = {
                    enabled = true;
                  };
                  ruff = {
                    enabled = true;
                  };
                };
              };
            };
          };

          # fonts
          buffer_font_family = "FiraCode Nerd Font";
          buffer_font_size = 14.5;
          ui_font_family = buffer_font_family;
          terminal = {
            font_family = "FiraCode Nerd Font Mono";
            font_size = buffer_font_size;
          };

          # ui
          minimap.show = "never";
          scrollbar = {
            axes.horizontal = false;
          };
          cursor_blink = false;

          #theme
          theme = {
            mode = config.stylix.polarity;
            dark = "Zedokai Classic";
            light = "Zedokai Classic";
          };
        };
      };
    };
  };
}
