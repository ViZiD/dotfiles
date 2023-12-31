{ pkgs, ... }:
let
  extensions = pkgs.nix-vscode-extensions;
in
{
  home-manager.users.radik = {
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = true;
      extensions = with extensions.vscode-marketplace; [
        vscodevim.vim
        github.vscode-pull-request-github
        eamodio.gitlens
        shd101wyy.markdown-preview-enhanced
        jnoortheen.nix-ide
        phoenixframework.phoenix
        jakebecker.elixir-ls
        animus-coop.vscode-elixir-mix-formatter
        esbenp.prettier-vscode
        ms-python.python
        ms-python.vscode-pylance
        be5invis.toml
        redhat.vscode-yaml
        redhat.vscode-xml
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        monokai.theme-monokai-pro-vscode
        editorconfig.editorconfig
        jyee721.babel-ast-explorer
        arichy.vscode-ast-explorer
        nicoespeon.abracadabra
      ];

      userSettings = {
        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        # "remote.SSH.externalSSH_ASKPASS" = true;
        # "remote.SSH.enableAgentForwarding" = true;
        # "remote.SSH.logLevel" = "debug";
        "remote.SSH.showLoginTerminal" = true;
        "prettier.useEditorConfig" = true;
        "emmet.triggerExpansionOnTab" = true;
        "emmet.includeLanguages" = {
          "phoenix-heex" = "html";
          "javascript" = "javascriptreact";
          "typescript" = "typescriptreact";
        };
        "editor.codeActionsOnSave" = {
          "source.fixAll.stylelint" = "explicit";
        };
        "[python]" = {
          "editor.formatOnSave" = true;
          "editor.codeActionsOnSave" = {
            "source.organizeImports.ruff" = "explicit";
            "source.fixAll" = "explicit";
          };
          "editor.formatOnType" = true;
        };
        "files.eol" = "\n";
        "workbench.iconTheme" = "Monokai Classic Icons";
        "javascript.suggestionActions.enabled" = true;
        "[javascript]" = {
          "editor.codeActionsOnSave" = {
            "source.fixAll" = true;
            "source.fixAll.eslint" = true;
          };
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.codeActionsOnSave" = {
            "source.fixAll" = true;
            "source.fixAll.eslint" = true;
          };
          "editor.formatOnSave" = true;
        };
        "git.autofetch" = true;
        "git.autoRepositoryDetection" = "openEditors";
        "git.enableCommitSigning" = true;
        "editor.autoClosingBrackets" = "always";
        "editor.formatOnSave" = true;
        "editor.fontFamily" = "FiraCode Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14.5;
        "editor.scrollBeyondLastLine" = false;
        "editor.padding.bottom" = 200;
        "terminal.integrated.tabs.enabled" = true;
        "terminal.integrated.defaultLocation" = "editor";
        "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
        "terminal.integrated.fontSize" = 16;
        "terminal.integrated.fontWeightBold" = "normal";
        "workbench.colorTheme" = "Monokai Classic";
        "security.workspace.trust.untrustedFiles" = "open";
        "[jsonc]" = {
          "editor.formatOnSave" = true;
        };
        "[html]" = {
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "files.associations" = {
          "*.json" = "json";
          "*.yml" = "yaml";
          "*.css" = "css";
        };
        "explorer.confirmDelete" = false;
        "editor.unicodeHighlight.allowedLocales" = {
          "ru" = true;
        };
        "git.useEditorAsCommitInput" = false;
        "[dockercompose]" = {
          "editor.formatOnSave" = true;
        };
        "redhat.telemetry.enabled" = false;
        "[dockerfile]" = {
          "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
        };
        "files.exclude" = {
          "**/.classpath" = true;
          "**/.project" = true;
          "**/.settings" = true;
          "**/.factorypath" = true;
        };
        "vim.hlsearch" = true;
        "vim.ignorecase" = true;
        "vim.showcmd" = false;
        "vim.smartcase" = true;
        "vim.useSystemClipboard" = true;
        "[yaml]" = {
          "editor.formatOnSave" = true;
        };
        "git.openRepositoryInParentFolders" = "never";
        "python.pipenvPath" = "${pkgs.pipenv}/bin/pipenv";
        "diffEditor.hideUnchangedRegions.enabled" = true;
        "[xml]" = {
          "editor.defaultFormatter" = "redhat.vscode-xml";
          "editor.formatOnSave" = true;
        };
        "[elixir]" = {
          "editor.defaultFormatter" = "animus-coop.vscode-elixir-mix-formatter";
          "editor.formatOnSave" = true;
        };
        "editor.defaultFormatter" = "EditorConfig.EditorConfig";
        "[css]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.formatOnSave" = true;
        };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.rnix-lsp}/bin/rnix-lsp";
        "[javascript][typescript]" = {
          "editor.codeActionsOnSave" = {
            "source.fixAll" = "explicit";
            "source.fixAll.eslint" = "explicit";
          };
        };
      };
    };
  };
}
