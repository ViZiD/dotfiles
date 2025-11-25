{
  config,
  lib,
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
        OPENROUTER_API_KEY = "$(cat ${config.vaultix.secrets.openrouter.path})";
        # ANTHROPIC_API_KEY = "$(cat ${config.vaultix.secrets.claude.path})";
        PERPLEXITY_API_KEY = "$(cat ${config.vaultix.secrets.perplexity.path})";
      };

      programs = {
        mods = {
          enable = true;
          settings = {
            default-api = "openrouter";
            default-model = "sonnet";
            enableZshIntegration = true;
            mcp-servers = {
              perplexity = {
                command = "npx";
                args = [
                  "-y"
                  "@perplexity-ai/mcp-server"
                ];
              };
              nixos = {
                command = "nix";
                args = [
                  "run"
                  "github:utensils/mcp-nixos"
                  "--"
                ];
              };
            };
            apis = {
              openrouter = {
                base-url = "https://openrouter.ai/api/v1";
                api-key-env = "OPENROUTER_API_KEY";
                models = {
                  "anthropic/claude-haiku-4.5" = {
                    aliases = [ "haiku" ];
                    max-input-chars = 680000;
                  };

                  "anthropic/claude-sonnet-4.5" = {
                    aliases = [ "sonnet" ];
                    max-input-chars = 680000;
                  };
                  "x-ai/grok-4.1-fast:free" = {
                    aliases = [ "grokfree" ];
                    max-input-chars = 2000000;
                  };
                  "x-ai/grok-4.1-fast" = {
                    aliases = [ "grok" ];
                    max-input-chars = 2000000;
                  };
                };
              };
            };
            roles = {
              code-reviewer = [ "You are a code reviewer. Focus on security, performance, and maintainability." ];
              shell = [
                "you are a shell expert"
                "you do not explain anything"
                "you simply output one liners to solve the problems you're asked"
                "you do not provide any explanation whatsoever, ONLY the command"
              ];
              claude-prompt-gen = [
                "You are a prompt generator."
                "Create prompts in this exact format without asking questions or providing
  explanations."
                "Output only the prompt in the specified structure."
                "Format: '---\nname: <kebab-case-only>\ndescription: <description>\ntools:
  <Read, Edit, Grep, or other Claude code permissions>\n---\n##
  Instructions\n\n<detailed instructions>\n\n## Examples\n\n<examples if
  applicable>'."
                "Generate the complete prompt based on user request in a single response
  with no additional commentary."
              ];
            };
          };
        };

        claude-code = {
          enable = true;
          agents = {
            based = ./agents/based.md;
          };
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
                "Edit"
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
              defaultMode = "acceptEdits";
            };
            includeCoAuthoredBy = false;
            apiKeyHelper = "cat ${config.vaultix.secrets.claude.path}"; # bypass stupid auth
            env = {
              DISABLE_AUTOUPDATER = 1;
              DISABLE_BUG_COMMAND = 1;
              DISABLE_ERROR_REPORTING = 1;
              DISABLE_TELEMETRY = 1;
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
          };
        };
      };
    };
  };
}
