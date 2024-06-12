# System and user package installtion

{ config, pkgs, inputs, ...}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add system pacakges
  environment.systemPackages = with pkgs; [
    wget
    # git
    kitty
    # brightnessctl
    ranger
    # wl-clipboard
    curl
    # htop
    # hypridle
    # hyprlock
    # hyprpaper
    # hyprdim
    # hyprshot
    # hyprpicker
    # hyprcursor
    # hyprlandPlugins.hy3
    whitesur-gtk-theme
    # wev
    # xdg-desktop-portal-hyprland
    # wofi
    # swaynotificationcenter
    # xcur2png
    # cmake
    polkit_gnome
    # lxqt.lxqt-policykit
  ];

}
