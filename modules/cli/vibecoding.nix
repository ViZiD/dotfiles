{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.lazygit;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.cli.vibecoding.enable = mkEnableOption "Enable vibecoding utils";

  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {

      stylix.targets = mkIf isStylesEnabled {
        opencode.enable = true;
      };

      home.sessionVariables = {
        OPENROUTER_API_KEY = "$(cat ${config.vaultix.secrets.openrouter.path})";
      };

      programs = {
        mods = {
          enable = true;
          settings = {
            default-api = "openrouter";
            default-model = "sonnet";

            apis.openrouter = {
              base-url = "https://openrouter.ai/api/v1";
              api-key-env = "OPENROUTER_API_KEY";
              models = {
                "anthropic/claude-haiku-4.5" = {
                  aliases = [ "haiku" ];
                  max-input-chars = 200000;
                };

                "anthropic/claude-sonnet-4.5" = {
                  aliases = [ "sonnet" ];
                  max-input-chars = 200000;
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
            };
          };
        };

        opencode = {
          enable = true;
          settings = {
            "$schema" = "https://opencode.ai/config.json";
            autoshare = false;
            autoupdate = false;
            model = "openrouter/anthropic/claude-sonnet-4.5";
            small_model = "openrouter/anthropic/claude-haiku-4.5";
            provider = {
              openrouter = {
                npm = "@openrouter/ai-sdk-provider";
                name = "OpenRouter";
                options = {
                  apiKey = "{file:${config.vaultix.secrets."openrouter".path}}";
                };
              };
            };
            agent = {
              code-reviewer = {
                mode = "primary";
                description = "Reviews code for best practices and potential issues";
                # model = "anthropic/claude-sonnet-4.5";
                model = "openrouter/anthropic/claude-sonnet-4.5";
                prompt = "You are a code reviewer. Focus on security, performance, and maintainability.";
                tools = {
                  write = false;
                  edit = false;
                };
              };
            };
            mcp = {
            };
          };
        };
      };
    };
  };
}
