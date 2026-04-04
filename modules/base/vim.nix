{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.base.vim;
  user = config.dots.user;
  isStylesEnabled = config.dots.styles.enable;
in
{
  options.dots.base.vim.enable = mkEnableOption "Enable vim editor";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      stylix.targets = mkIf isStylesEnabled {
        vim.enable = true;
      };
      programs.vim = {
        enable = true;
        extraConfig = ''
          syntax on
          filetype plugin indent on
          set nocompatible
          set hidden
          set wildmenu
          set showcmd
          set incsearch
          set hlsearch
          set backspace=indent,eol,start
          set autoindent
          set nostartofline
          set ruler
          set laststatus=2
          set confirm
          set visualbell
          set t_vb=
          set cmdheight=2
          set number
          set notimeout ttimeout ttimeoutlen=200
          set softtabstop=4
          set expandtab
          map Y y$
          set shiftwidth=4
          set tabstop=8
        '';
      };
    };
  };
}
