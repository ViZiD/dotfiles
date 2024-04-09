{ pkgs, lib, ... }: {

  environment.sessionVariables = {
    XCURSOR_PATH = lib.mkForce "/home/radik/.icons";
    XCURSOR_SIZE = lib.mkForce "16";
  };

  home-manager.users.radik = {
    home.pointerCursor = {
      package = pkgs.simp1e-cursors;
      name = "Simp1e";
      size = 16;
    };
  };
}
