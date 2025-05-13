{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dots.dev;
  user = config.dots.user;
  isPersistEnabled = config.dots.shared.persist.enable;
in
{
  options.dots.dev.ops.enable = mkEnableOption "Enable devops config";
  config = mkIf cfg.enable {
    dots.shared.persist = mkIf (isPersistEnabled && user.enable) {
      user = {
        directories = [
          ".minikube"
        ];
        files = [
          ".kube/config"
          ".docker/config.json"
        ];
      };
    };
    virtualisation.docker = {
      enable = true;
    };
    home-manager.users.${user.username} = mkIf user.enable {
      home.packages = with pkgs; [
        kubectl
        kubectx
        kubent
        kubetail
        kubectx
        minikube
        kubernetes-helm
        docker-compose
        opentofu
      ];
    };
  };
}
