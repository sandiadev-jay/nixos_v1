# System and user package installtion

{ config, pkgs, inputs, ...}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add system pacakges
  environment.systemPackages = with pkgs; [
    wget
    kitty
    ranger
    curl
    whitesur-gtk-theme
    polkit_gnome
    linuxHeaders
  ];

}
