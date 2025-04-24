{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.base.zsh;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;

  base = {
    enable = true;

    enableCompletion = true;

    syntaxHighlighting.enable = false;

    shellAliases = {
      "cat" = "${pkgs.bat}/bin/bat";
      "ls" = "${pkgs.eza}/bin/eza -alhH --icons=always --git";
    };
  };
in
{
  options.dots.base.zsh.enable = mkEnableOption "Enable zsh";
  config = mkIf cfg.enable {

    dots.shared.persist.user = mkIf isPersistEnabled {
      files = [
        ".local/share/zsh/history"
      ];
    };

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
    } // base;

    users.users.${user.username} = mkIf user.enable { shell = pkgs.zsh; };

    home-manager.users.${user.username} = mkIf user.enable {
      programs.zsh = {
        plugins = [
          {
            name = "shrink-path";
            file = "plugins/shrink-path/shrink-path.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "ohmyzsh";
              repo = "ohmyzsh";
              rev = "11e84bf4f783100c162f2273d72fccc22eb2756d";
              sha256 = "sha256-CoHkNdasdwnb6Ciu/uiAuBnbugWCLLohTH56x6LKoTk=";
            };
          }
        ];
        dotDir = ".config/zsh";

        autosuggestion.enable = true;

        history = rec {
          expireDuplicatesFirst = true;
          extended = true;
          ignoreAllDups = true;
          size = 100000000;
          save = size;
          path = "$HOME/.local/share/zsh/history";
        };

        initContent = ''
          setopt prompt_subst
          autoload -Uz vcs_info add-zsh-hook

          zstyle ':vcs_info:*' enable git
          zstyle ':vcs_info:git:*' check-for-changes true
          zstyle ':vcs_info:git:*' formats '%c%u%F{yellow}%b%f'
          zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
          zstyle ':vcs_info:git:*' unstagedstr '%F{red}*%f'

          zstyle ':prompt:shrink_path' fish yes
          zstyle ':prompt:shrink_path' tilde yes
          zstyle ':prompt:shrink_path' last yes
          zstyle ':prompt:shrink_path' short yes
          zstyle ':prompt:shrink_path' nameddirs no

          function _prompt_generator() { 
            prompt='%F{green}%n%f@%F{magenta}%m%f:$(shrink_path) >'

            if [[ ! -z $vcs_info_msg_0_ && -z $SSH_TTY ]]; then
              prompt='%F{green}%n%f@%F{magenta}%m%f:$(shrink_path) ''${vcs_info_msg_0_} >'
            fi
          }

          add-zsh-hook precmd vcs_info
          add-zsh-hook precmd _prompt_generator

          cpr() {
            ${pkgs.rsync}/bin/rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
          }
          mvr() {
            ${pkgs.rsync}/bin/rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
          }

          fext () {
            ${pkgs.file}/bin/file -b --extension "$@" |
            sed -e 's-^jpeg/jpg/jpe/jfif$-jpg-' |
            sed -e 's-^pdf$-PDF-' |
            sed -e 's-^tif,tiff$-tiff-' |
            sed -e 's-^???$-unknown-' |
            cat
          }
        '';
      } // base;
    };
  };
}
