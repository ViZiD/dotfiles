{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.lazygit;
  user = config.dots.user;
in
{
  options.dots.cli.vibecoding.enable = mkEnableOption "Enable vibecoding utils";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {

      home.sessionVariables = {
        OPENROUTER_API_KEY = "$(cat ${config.vaultix.secrets.openrouter.path})";
        ANTHROPIC_API_KEY = "$(cat ${config.vaultix.secrets.claude.path})";
        PERPLEXITY_API_KEY = "$(cat ${config.vaultix.secrets.perplexity.path})";
      };

      programs = {
        mods = {
          enable = true;
          settings = {
            default-api = "openrouter";
            default-model = "sonnet";

            apis = {
              openrouter = {
                base-url = "https://openrouter.ai/api/v1";
                api-key-env = "OPENROUTER_API_KEY";
                models = {
                  "anthropic/claude-haiku-4.5" = {
                    aliases = [ "or-haiku" ];
                    max-input-chars = 680000;
                  };

                  "anthropic/claude-sonnet-4.5" = {
                    aliases = [ "or-sonnet" ];
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
              # bug https://github.com/charmbracelet/mods/pull/624
              # anthropic = {
              #   base-url = "https://api.anthropic.com/v1";
              #   api-key-env = "ANTHROPIC_API_KEY";
              #   models = {
              #     "claude-haiku-4-5" = {
              #       aliases = [ "haiku" ];
              #       max-input-chars = 680000;
              #     };
              #     "claude-sonnet-4-5" = {
              #       aliases = [ "sonnet" ];
              #       max-input-chars = 680000;
              #     };
              #   };
              # };
            };
            roles = {
              code-reviewer = [ "You are a code reviewer. Focus on security, performance, and maintainability." ];
              shell = [
                "you are a shell expert"
                "you do not explain anything"
                "you simply output one liners to solve the problems you're asked"
                "you do not provide any explanation whatsoever, ONLY the command"
              ];
            };
          };
        };

        opencode = {
          enable = true;
          settings = {
            "$schema" = "https://opencode.ai/config.json";
            instructions = [
              "CONTRIBUTING.md"
              "CLAUDE.md"
              "WARP.md"
              ".cursor/rules/*.md"
              "notes/*.md"
            ];
            theme = "monokai";
            autoshare = false;
            autoupdate = false;
            model = "anthropic/claude-sonnet-4-5";
            small_model = "anthropic/claude-haiku-4-5";
            provider = {
              anthropic = {
                name = "Anthropic";
                options = {
                  apiKey = "{env:ANTHROPIC_API_KEY}";
                };
              };
              openrouter = {
                npm = "@openrouter/ai-sdk-provider";
                name = "OpenRouter";
                options = {
                  apiKey = "{env:OPENROUTER_API_KEY}";
                };
              };
            };
            agent = {
              code-reviewer = {
                description = "Reviews code for best practices and potential issues";
                model = "anthropic/claude-sonnet-4-5";
                prompt = "You are a code reviewer. Focus on security, performance, and maintainability.";
                tools = {
                  write = false;
                  edit = false;
                };
              };
              based = {
                mode = "primary";
                model = "anthropic/claude-sonnet-4-5";
                prompt = "You are an expert software engineer with deep knowledge across multiple
  programming languages, frameworks, and best practices; provide clear,
  concise, production-ready code solutions with brief explanations, prioritize
  clean architecture and performance, include error handling where relevant,
  and adapt your response complexity to match the question's scope.";
                tools = {
                  read = true;
                  edit = true;
                };
              };
            };
            mcp = {
              perplexity = {
                type = "local";
                command = [
                  "npx"
                  "-y"
                  "@perplexity-ai/mcp-server"
                ];
                enabled = true;
              };
              nixos = {
                type = "local";
                command = [
                  "nix"
                  "run"
                  "github:utensils/mcp-nixos"
                  "--"
                ];
                enabled = true;
              };
              deepwiki = {
                type = "remote";
                url = "https://mcp.deepwiki.com/mcp";
                enabled = true;
              };
            };
          };
        };
      };
    };
  };
}
