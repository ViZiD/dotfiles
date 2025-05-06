{
  outputs,
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

    # force spotify use xwayland
    # remove ugly CSD
    spotify = prev.spotify.overrideAttrs (oldAttrs: {
      postInstall =
        oldAttrs.postInstall or ""
        + ''
          wrapProgram $out/bin/spotify \
            --add-flags "--ozone-platform=x11"
        '';
      postFixup = ''
        substituteInPlace $out/share/applications/spotify.desktop \
          --replace "Exec=spotify %U" "Exec=env NIXOS_OZONE_WL= spotify %U --ozone-platform=x11"
      '';
    });
  };

  nix-vscode-extensions = final: prev: {
    nix-vscode-extensions = inputs.vscode-ext.overlays.default final prev;
  };
}
