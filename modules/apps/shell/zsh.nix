{ pkgs, ... }: {
  environment.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  environment.pathsToLink = [ "/share/zsh" ];

  programs.zsh.enable = true;

  home-manager.users.radik.programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;

    dotDir = ".config/zsh";

    sessionVariables = {
      TERM = "xterm-256color";
    };

    shellAliases = {
      "cat" = "${pkgs.bat}/bin/bat";
      "ls" = "${pkgs.eza}/bin/eza -alh";

      "gdd" = "${pkgs.git}/bin/git add .";
      "gda" = "${pkgs.git}/bin/git add -A";
      "gcm" = "${pkgs.git}/bin/git commit -m";
    };

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
        rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
      } 
      mvr() {
        rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
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
  };
}


