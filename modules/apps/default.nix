let
  archive = "org.gnome.FileRoller";
  image = "feh";
  browser = "brave-browser.desktop";
  editor = "hx";
  reader = "zathura";
in
{
  environment.sessionVariables = {
    EDITOR = editor;
    VISUAL = editor;
  };

  home-manager.users.radik.xdg.mimeApps = {
    enable = true;

    associations.added = {
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "image/*" = image;
      "application/zip" = archive;
      "application/rar" = archive;
      "application/7z" = archive;
      "application/*tar" = archive;

      "application/pdf" = reader;

      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;
    };
  };
}
