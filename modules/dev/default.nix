{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.dev;
in
{
  imports = [
    ./python
    ./js
    ./elixir
    ./ops.nix
  ];
  options.dots.dev.enable = mkEnableOption "Enable dev stuff";
  config = mkIf cfg.enable {
    dots.dev = {
      js.enable = true;
      python.enable = true;
      elixir.enable = true;
      ops.enable = true;
    };
  };
}
