{ pkgs, ... }:
let
  extensions = pkgs.nix-vscode-extensions;
in
{
  home-manager.users.radik = {
    programs.vscode = {
      enable = true;

      mutableExtensionsDir = false;
      extensions = with extensions.vscode-marketplace; [
        vscodevim.vim
        jnoortheen.nix-ide
        esbenp.prettier-vscode
        ms-python.python
        ms-python.vscode-pylance
        ms-python.mypy-type-checker
        charliermarsh.ruff
        tamasfe.even-better-toml
        redhat.vscode-yaml
        redhat.vscode-xml
        ms-azuretools.vscode-docker
        monokai.theme-monokai-pro-vscode
        pkief.material-icon-theme
        editorconfig.editorconfig
        mkhl.direnv
        rust-lang.rust-analyzer
        gleam.gleam
        dart-code.dart-code
        dart-code.flutter
        psioniq.psi-header
      ];

      userSettings = {
        "telemetry.telemetryLevel" = "off";
        "update.mode" = "none";
        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        "prettier.useEditorConfig" = true;
        "emmet.triggerExpansionOnTab" = true;
        "editor.codeActionsOnSave" = {
          "source.fixAll.stylelint" = "always";
        };
        "[python]" = {
          "editor.formatOnSave" = true;
          "editor.codeActionsOnSave" = {
            "source.fixAll" = "always";
            "source.organizeImports" = "always";
          };
          "editor.defaultFormatter" = "charliermarsh.ruff";
        };
        "ruff.path" = [ "${pkgs.ruff}/bin/ruff" ];
        "files.eol" = "\n";
        "git.autofetch" = true;
        "git.autoRepositoryDetection" = "openEditors";
        "git.enableCommitSigning" = true;
        "editor.autoClosingBrackets" = "always";
        "editor.formatOnSave" = true;
        "editor.fontFamily" = "FiraCode Nerd Font";
        "editor.fontLigatures" = false;
        "editor.fontSize" = 14.5;
        "editor.scrollBeyondLastLine" = false;
        "editor.padding.bottom" = 200;
        "terminal.integrated.tabs.enabled" = true;
        "terminal.integrated.defaultLocation" = "editor";
        "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
        "terminal.integrated.fontSize" = 16;
        "terminal.integrated.fontWeightBold" = "normal";
        "workbench.colorTheme" = "Monokai Classic";
        "workbench.iconTheme" = "material-icon-theme";
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
        "[javascriptreact]" = {
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
          # "**/.classpath" = true;
          # "**/.project" = true;
          # "**/.settings" = true;
          # "**/.factorypath" = true;
          "**/.mypy_cache" = true;
        };
        "vim.hlsearch" = true;
        "vim.ignorecase" = true;
        "vim.showcmd" = false;
        "vim.smartcase" = true;
        "vim.useSystemClipboard" = true;
        "vim.leader" = "<space>";
        "vim.normalModeKeyBindings" = [
          {
            "before" = [
              "<leader>"
              "a"
            ];
            "commands" = [ "workbench.view.explorer" ];
          }
        ];
        "extensions.experimental.affinity" = {
          "vscodevim.vim" = 1;
        };
        "[yaml]" = {
          "editor.formatOnSave" = true;
        };
        "[toml]" = {
          "editor.defaultFormatter" = "tamasfe.even-better-toml";
          "editor.formatOnSave" = true;
        };
        "git.openRepositoryInParentFolders" = "never";
        "diffEditor.hideUnchangedRegions.enabled" = true;
        "[xml]" = {
          "editor.defaultFormatter" = "redhat.vscode-xml";
          "editor.formatOnSave" = true;
        };
        "editor.defaultFormatter" = "EditorConfig.EditorConfig";
        "[css]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.formatOnSave" = true;
        };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nil}/bin/nil";
        "nix.serverSettings" = {
          "nil" = {
            "diagnostics" = {
              "ignored" = [
                "unused_binding"
                "unused_with"
              ];
            };
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
        "[javascript][typescript]" = {
          "editor.codeActionsOnSave" = {
            "source.fixAll" = "always";
            "source.fixAll.eslint" = "always";
          };
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "javascript.suggestionActions.enabled" = true;
        "typescript.suggestionActions.enabled" = true;
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
          "editor.formatOnSave" = true;
        };
        "[dart]" = {
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.rulers" = [ 80 ];
          "editor.selectionHighlight" = false;
          "editor.suggestSelection" = "first";
          "editor.tabCompletion" = "onlySnippets";
          "editor.wordBasedSuggestions" = "off";
        };
        "dart.checkForSdkUpdates" = false;
        "psi-header.config" = {
          "author" = "Radik Islamov";
          "authorEmail" = "vizid1337@gmail.com";
          "license" = "MIT";

          "forceToTop" = true;
          "blankLinesAfter" = 1;
          "spacesBetweenYears" = false;
          "enforceHeader" = true;
        };
        "psi-header.templates" = [
          {
            "language" = "*";
            "template" = [
              "Copyright (C) <<year>> <<author>> <<<authorEmail>>>"
              "SPDX-License-Identifier: <<spdxid>>"
            ];
          }
        ];
        "psi-header.lang-config" = [
          {
            "language" = "python";
            "prefix" = "# ";
            "end" = "";
            "begin" = "";
          }
          {
            "language" = "toml";
            "mapTo" = "python";
          }
          {
            "language" = "yaml";
            "mapTo" = "python";
          }
          {
            "language" = "shellscript";
            "mapTo" = "python";
          }
          {
            "language" = "javascript";
            "begin" = "";
            "prefix" = " * ";
            "end" = "";
          }
          {
            "language" = "typescript";
            "mapTo" = "javascript";
          }
          {
            "language" = "markdown";
            "begin" = "<!--";
            "prefix" = "";
            "end" = "-->";
          }
        ];
      };
    };
  };
}
