{ pkgs, ... }:

{
  # Hyprlock config
  programs.hyprlock = {
    
    enable = true;
    
    settings = {

      general = {
        disable_loading_bar = false;
        grace = 3;
        no_fade_in = true;
        no_fade_out = false;
        hide_cursor = true;
      };

      # Set background image
      background = {
        monitor = "";
        path = "/home/jay/Documents/Backgrounds/kids_cloudcroft.jpg";
      };

      # Input field settings
      input-field = {
        monitor = "";
        size = "300, 75";
        outline_thickness = 5;
        dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = false;
        dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
        outer_color = "rgb(0, 0, 0)";
        inner_color = "rgb(255, 255, 255)";
        font_color = "rgb(10, 10, 10)";
        fade_on_empty = true;
        fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
        placeholder_text = "<i>Input Password...</i>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        rounding = -1; # -1 means complete rounding (circle/oval)
        check_color = "rgb(204, 136, 34)";
        fail_color = "rgb(204, 34, 34)"; # if authentication failed, changes outer_color and fail message color
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
        fail_transition = 300; # transition time in ms between normal outer_color and fail_color
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false; # change color if numlock is off
        swap_font_color = false; # see below

        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      # Labels
      label = [
        {
          # Time Label
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
          # color = $foreground
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 150;
          font_family = "Noto Sans Bold";
          position = "0, -600";
          halign = "center";
          valign = "top";
          shadow_pass = 3;
          shadow_size = 3;
          shadow_color = "rgb(0, 0, 0)";
          shadow_boost = 1.2;
        }
        {
          # User Label
          monitor = "";
          text = "Hi there, Jay!";
          color = "rgba(255, 255, 255, 1.0)";
          font_size = 64;
          font_family = "Noto Sans";
          rotate = 0; # degrees, counter-clockwise
          position = "0, 100";
          halign = "center";
          valign = "center";
          shadow_pass = 3;
          shadow_size = 3;
          shadow_color = "rgb(0, 0, 0)";
          shadow_boost = 1.2;
        }
      ];
    };
  };
}