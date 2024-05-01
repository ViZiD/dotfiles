{
  home-manager.users.radik =
    { config, pkgs, ... }:
    {
      home = {
        file = {
          ".config/polybar" = {
            recursive = true;
            source = config.lib.file.mkOutOfStoreSymlink ./config;
          };
        };
        packages = with pkgs; [
          (polybar.override {
            pulseSupport = true;
            iwSupport = true;
            nlSupport = true;
          })
        ];
      };
    };
}
