# This holds the sway configuration
{ config, pkgs, inputs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    swaynag.enable = true;
  };
}