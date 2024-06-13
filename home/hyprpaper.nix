{ config, pkgs, ... }:

{
  # Hyprpaper config
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/jay/Documents/Backgrounds/britt_kids_hiking_sandiacave.jpg" ];
      wallpaper = [ ",/home/jay/Documents/Backgrounds/britt_kids_hiking_sandiacave.jpg" ];
    };
  };
}