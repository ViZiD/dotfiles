{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.dots.cli.gh;
  user = config.dots.user;
  hmConfig = config.home-manager.users.${user.username};
in
{
  options.dots.cli.gh.enable = mkEnableOption "Enable github stuff";
  config = mkIf cfg.enable {
    home-manager.users.${user.username} = mkIf user.enable {
      programs = {
        gh.enable = true;
        gh-dash = {
          enable = true;
          settings = {
            prSections = [
              {
                title = "My Pull Requests";
                filters = "is:open author:@me";
                layout.author.hidden = true;
              }
              {
                title = "Needs My Review";
                filters = "is:open review-requested:@me";
              }
              {
                title = "Involved";
                filters = "is:open involves:@me -author:@me";
              }
              {
                title = "Nixpkgs Approved r-ryantm";
                filters = ''repo:NixOS/nixpkgs is:pr is:open author:r-ryantm label:"12.approved-by: package-maintainer"'';
                layout = {
                  author.hidden = true;
                  repo.hidden = true;
                };
              }
            ];
            pager.diff = if hmConfig.programs.delta.enable then "delta" else "less";
          };
        };
      };
    };
  };
}
