# Adding default applications using XDG Mime

{ config, pkgs, ... }:

{
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "google-chrome-stable.desktop";
      "image/png" = "gimp.desktop";
      "text/html" = "google-chrome-stable.desktop";
      "inode/directory" = "ranger.desktop";
    };
  };
}
