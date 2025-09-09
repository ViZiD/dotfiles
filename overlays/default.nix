{
  # deadnix: skip
  outputs,
  # deadnix: skip
  inputs,
}:
let
  addPatches =
    pkg: patches:
    pkg.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ patches;
    });
in
{
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (
      _: flake:
      let
        legacyPackages = (flake.legacyPackages or { }).${final.system} or { };
        packages = (flake.packages or { }).${final.system} or { };
      in
      if legacyPackages != { } then legacyPackages else packages
    ) inputs;
  };

  master = final: _: {
    master = inputs.nixpkgs-master.legacyPackages.${final.system};
  };

  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };

  nixpkgs-24-11 = final: _: {
    nixpkgs-24-11 = inputs.nixpkgs-24-11.legacyPackages.${final.system};
  };

  # Adds my custom packages
  # deadnix: skip
  additions = final: prev: import ../pkgs { pkgs = final; } // { };
  # deadnix: skip

  # Modifies existing packages
  # deadnix: skip
  modifications = final: prev: {
    # deadnix: skip
    intel-vaapi-driver = prev.intel-vaapi-driver.override { enableHybridCodec = true; };
    passExtensions = prev.passExtensions // {
      # https://github.com/tadfisher/pass-otp/pull/173
      pass-otp = addPatches prev.passExtensions.pass-otp [ ./patches/pass-otp-fix-completion.patch ];
    };
    libratbag = addPatches prev.libratbag [ ./patches/ergo-m575s-device.patch ];
  };

  nix-vscode-extensions = final: prev: {
    nix-vscode-extensions = inputs.vscode-ext.overlays.default final prev;
  };
}
