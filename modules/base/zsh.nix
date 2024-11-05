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
        dotDir = ".config/zsh";

        autosuggestion.enable = true;

        history = rec {
          expireDuplicatesFirst = true;
          extended = true;
          ignoreAllDups = true;
          size = 10000;
          save = size;
          path = "$HOME/.local/share/zsh/history";
        };

        initExtra = ''
          autoload -Uz promptinit && promptinit
          prompt_susecolor_setup(){
            PS1="%F{green}%n%f@%F{magenta}%m%f:%~/ >"
          }
          prompt_themes+=(susecolor)
          prompt susecolor

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
