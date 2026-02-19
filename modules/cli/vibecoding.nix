{
  config,
  lib,
  pkgs,
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

      # home.packages = with pkgs.inputs.llm-agents-nix; [
      # ];

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
            DISABLE_AUTOUPDATER = 1;
            DISABLE_BUG_COMMAND = 1;
            DISABLE_ERROR_REPORTING = 1;
            DISABLE_TELEMETRY = 1;
            USE_BUILTIN_RIPGREP = 0;
            CLAUDE_CODE_HIDE_ACCOUNT_INFO = 1;
            FORCE_AUTOUPDATE_PLUGINS = true;
          };
        };
        mcpServers = {
          nixos = {
            args = [
              "run"
              "github:utensils/mcp-nixos"
              "--"
            ];
            command = "nix";
            type = "stdio";
          };
          deepwiki = {
            type = "http";
            url = "https://mcp.deepwiki.com/mcp";
          };
          time = {
            command = "uvx";
            args = [
              "mcp-server-time"
            ];
            type = "stdio";
          };
        };
      };
    };
  };
}
