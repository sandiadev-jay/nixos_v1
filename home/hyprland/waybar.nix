{ inputs, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
    
      mainbar = {
        
        # General positional settings
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;

        # Module Layout
        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];

        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "bluetooth"
          # "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          # "hyprland/language"
          "battery"
          # "battery#bat2"
          "clock"
        ];

        # Module configurations
        "hyprland/workspaces" = {
          format = "{name}: {windows} |";
          format-window-separator = " ";
          window-rewrite-default = "";
          window-rewrite = {
            chrome = "";
            firefox = "󰈹";
            code = "";
            kitty = "";
            nwg-look = "";
            brave = "󰄛";
            "1password" = "";
          };
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "hyprland/submap" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = ["" ""];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰈈 ";
            deactivated = " ";
          };
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%Y-%m-%d|%H:%M}";
        };

        cpu = {
          format = "{usage}% ";
          tooltip = "CPU Usage {usage}%";
        };

        memory = {
          format = "{}%  ";
        };

        temperature = {
          thermal-zone = 13;
          critical-threshold = 80;
          format-critical = "{temperatureC}C {icon}";
          format = "{temperatureC}C {icon}";
          format-icons = ["" "" ""];
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon} {time}";
          format-time = "{H}:{M}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰚥";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) {icon}";
          format-ethernet = "{ipaddr}/{cidr} 󰈀";
          tooltip-format = "{ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
        };

        pulseaudio = {
          # // "scroll-step": 1; // %; can be a float
          format = "{volume}% {icon}  {format_source}";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = "󰸈 {icon}  {format_source}";
          format-muted = "{volume}% 󰸈  {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "{volume}% 󰍭";
          format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["󰕿" "󰖀" "󰕾"];
          };
          # on-click = "pavucontrol";
        };

        bluetooth = {
          format = "󰂯 {status}";
          format-disabled = "󰂲 {status}"; # an empty format will hide the module
          format-connected = " {num_connections} connected";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          # on-click = "blueman-manager";
        };

      #   "custom/media" = {
      #     format=  "{icon} {}";
      #     return-type=  "json";
      #     max-length=  40;
      #     format-icons=  {
      #         spotify =  "";
      #         default =  "🎜";
      #     };
      #     escape = true;
      #     exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
      #     exec = "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null"; # Filter player based on name
      # };
      };
    };
  };
}