{ pkgs, ... }:

let
  genPkgs = pkgs.callPackage ./packages { inherit pkgs; };

  extPkgs = with genPkgs // { rush-microsoft = genPkgs."@microsoft/rush"; }; [
    webcrack
    rush-microsoft
  ];
  nixPkgs = with pkgs.nodePackages; [
    # http-server
    # rollup
    # svgo
    # sloc
    # js-beautify
    # tern
    # bower
    yo
    eslint_d
    prettier
    typescript
    typescript-language-server
  ];
in
{
  home-manager.users.radik = {
    home = {
      packages =
        with pkgs;
        [
          nodejs_latest
          yarn
        ]
        ++ nixPkgs
        ++ extPkgs;
    };
  };
}
