inputs: final: prev: {
  nix-vscode-extensions = inputs.vscode-ext.overlays.default final prev;
  age-plugin-openpgp-card = prev.callPackage ./age-plugin-openpgp-card.nix { };
}
