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

      programs.claude-code = {
        enable = true;
        package = pkgs.inputs.llm-agents-nix.claude-code;
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
            # lsp
            "typescript-lsp@claude-plugins-official" = true;
            "pyright-lsp@claude-plugins-official" = true;
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
                    command = with pkgs.inputs.llm-agents-nix; "${rtk}/libexec/rtk/hooks/rtk-rewrite.sh";
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
