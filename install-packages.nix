# System and user package installtion

{ config, pkgs, inputs, ...}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add user packages for user jay
  # users.users.jay.packages = with pkgs; [
    # firefox
    # google-chrome
    # brave
    # unzip
    # wineWowPackages.waylandFull
    # winetricks
    # vscode-fhs
    # blender
    # julia
    # go
    # p7zip
    # musescore
    # gnutar
    # nodejs_22
    # mesa-demos
    # gimp
    # obs-studio
    # vlc
    # nwg-look
    # unrar
    # renpy
    # libreoffice-qt6-still
    # unityhub
  # ];

  # Add system pacakges
  environment.systemPackages = with pkgs; [
    wget
    # git
    kitty
    brightnessctl
    ranger
    wl-clipboard
    curl
    htop
    hypridle
    hyprlock
    hyprpaper
    hyprdim
    hyprshot
    hyprpicker
    hyprcursor
    hyprlandPlugins.hy3
    whitesur-gtk-theme
    wev
    xdg-desktop-portal-hyprland
    wofi
    swaynotificationcenter
    xcur2png
    cmake
    polkit_gnome
    # lxqt.lxqt-policykit
  ];

}
