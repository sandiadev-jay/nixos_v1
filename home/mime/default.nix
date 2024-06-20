{ inputs, pkgs, ... }:

{
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["draw.desktop" "google-chrome-stable.desktop"];
      "application/msword" = ["writer.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["writer.desktop"];
      "image/png" = ["gimp.desktop" "google-chrome-stable.desktop"];
      "image/jpeg" = ["gimp.desktop" "google-chrome-stable.desktop"];
      "image/jpg" = ["gimp.desktop" "google-chrome-stable.desktop"];
      "indoe/directory" = ["ranger.desktop"];
      "text/html" = ["google-chrome-stable.desktop" "firefox.desktop"];
      "text/css" = ["code.desktop" "micro.desktop"];
      "text/csv" = ["calc.desktop" "code.desktop" "micro.desktop"];
      "text/js" = ["code.desktop" "micro.desktop"];
      "text/json" = ["code.desktop" "micro.desktop"];
    };
  };
}