inputs: final: prev: {
  nix-vscode-extensions = inputs.vscode-ext.overlays.default final prev;
  nix-gaming = inputs.nix-gaming.overlays.default final prev;
}
