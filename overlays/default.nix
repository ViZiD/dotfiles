inputs: final: prev: {
  nix-vscode-extensions = inputs.vscode-ext.overlays.default final prev;
}
