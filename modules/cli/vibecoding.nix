{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
let
  cfg = config.dots.cli.lazygit;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
  claudePackage = pkgs.inputs.llm-agents-nix.claude-code;
  lspPluginDir = "/home/${user.username}/.claude/plugins/nix-lsp";
  claudeWithLsp = pkgs.symlinkJoin {
    name = "claude-code-with-lsp";
    paths = [ claudePackage ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude \
        --set ENABLE_LSP_TOOL 1 \
        --add-flags "--plugin-dir ${lspPluginDir}"
    '';
  };
in
{
  options.dots.cli.vibecoding.enable = mkEnableOption "Enable vibecoding utils";

  config = mkIf cfg.enable {
    dots.shared.persist.user = mkIf isPersistEnabled {
      directories = [
        ".claude"
      ];
    };

    home-manager.users.${user.username} = mkIf user.enable {
      home.sessionVariables = {
        PERPLEXITY_API_KEY = "$(cat ${config.sops.secrets.perplexity.path})";
      };

      home.packages = with pkgs.inputs.llm-agents-nix; [
        rtk
      ];

      home.file.".claude/plugins/nix-lsp/.lsp.json".text = builtins.toJSON {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
          extensionToLanguage.".nix" = "nix";
        };
        typescript = {
          command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          args = [ "--stdio" ];
          extensionToLanguage = {
            ".ts" = "typescript";
            ".tsx" = "typescriptreact";
            ".js" = "javascript";
            ".jsx" = "javascriptreact";
          };
        };
        pyright = {
          command = "${pkgs.pyright}/bin/pyright-langserver";
          args = [ "--stdio" ];
          extensionToLanguage = {
            ".py" = "python";
            ".pyi" = "python";
          };
        };
      };

      programs.claude-code = {
        enable = true;
        package = claudeWithLsp;
        #
        # agents = {
        # };
        settings = {
          extraKnownMarketplaces = {
            perplexity-mcp-server = {
              source.source = "github";
              source.repo = "perplexityai/modelcontextprotocol";
            };
          };
          enabledPlugins = {
            "perplexity@perplexity-mcp-server" = true;
          };
          permissions = {
            disableBypassPermissionsMode = "disable";
            allow = [
              "Bash(git diff:*)"
              "WebSearch"
              "WebFetch(domain:docs.letta.com)"
            ];
            ask = [
              "Bash(git push:*)"
            ];
            deny = [
              "Read(./.env)"
              "Read(./.env.*)"
              "Read(./secrets/**)"
              "Read(./venv/**)"
              "Read(./config/credentials.json)"
              "Read(./build)"
            ];
          };
          language = "russian";
          spinnerTipsEnabled = false;
          respectGitignore = true;
          includeCoAuthoredBy = false;
          # apiKeyHelper = "cat ${config.sops.secrets.claude.path}"; # bypass stupid auth
          env = {
            DISABLE_AUTOUPDATER = "1";
            DISABLE_BUG_COMMAND = "1";
            DISABLE_ERROR_REPORTING = "1";
            DISABLE_TELEMETRY = "1";
            USE_BUILTIN_RIPGREP = "0";
            CLAUDE_CODE_HIDE_ACCOUNT_INFO = "1";
            FORCE_AUTOUPDATE_PLUGINS = "true";
            ENABLE_TOOL_SEARCH = "true";
          };
          hooks = {
            PreToolUse = [
              {
                matcher = "Bash";
                hooks = [
                  {
                    type = "command";
                    command = with pkgs.inputs.llm-agents-nix; "${rtk}/libexec/rtk/hooks/claude/rtk-rewrite.sh";
                  }
                ];
              }
            ];
            Notification = [
              {
                matcher = "";
                hooks = [
                  {
                    type = "command";
                    command = "${pkgs.jq}/bin/jq -r .message | ${pkgs.curl}/bin/curl -sL -H 'Title: Claude Code' -H \"Authorization: Bearer $(cat ${config.sops.secrets.ntfy_token_claude.path})\" -d @- https://notify.vizqq.cc/$(cat ${config.sops.secrets.ntfy_claude_path.path})";
                  }
                ];
              }
            ];
          };
        };
        mcpServers =
          (inputs.mcp-servers-nix.lib.evalModule pkgs {
            programs = {
              # my pc to slow for this... sad
              # serena = {
              #   enable = true;
              #   context = "claude-code";
              #   enableWebDashboard = false;
              # };
              fetch = {
                enable = true;
                type = "http";
                url = "https://mcp.deepwiki.com/mcp";
              };
              nixos.enable = true;
              time.enable = true;
            };
          }).config.settings.servers;
      };
    };
  };
}
