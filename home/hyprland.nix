{ config, pkgs, ... }:

{
  # Ancillary service enablement
  programs.waybar.enable = true;
  programs.hyprlock.enable = true;
  services.swaync.enable = true;
  programs.wofi.enable = true;
  
  # Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    systemd.variables = ["--all"];
    xwayland.enable = true;


    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = false;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 0, 7, myBezier"
          "windowsOut, 0, 7, default, popin 80%"
          "border, 0, 10, default"
          "borderangle, 0, 8, default"
          "fade, 0, 7, default"
          "workspaces, 0, 6, default"
        ];
      };

      # Set up monitor preferences
      monitor = [
        ", preferred, auto, auto"
        "eDP-1, preferred, -1729x1080, 2"
        "desc:Samsung Electric Company U32R59x HNAR100470, preferred, 0x0, 1"
        "desc:Samsung Electric Company U32R59x H4ZM712156, preferred, 3840x0, 1"
      ];

      # Bind workspaces to monitors
      workspace = [
        "1, monitor:eDP-1, default:true"
        "2, monitor:desc:Samsung Electric Company U32R59x HNAR100470, default:true"
        "3, monitor:desc:Samsung Electric Company U32R59x H4ZM712156, default:true"
      ];

      # Dwindle is standard - use mod P to toggle
      dwindle = {
        pseudotile = true; 
        preserve_split = true;
      };

      # Master is alternate, new is master
      master = {
        new_is_master = true;
      };

      misc = {
        force_default_wallpaper = 0;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vfr = false;  # Frame rate reduction when no changes occur, true could save battery life
      };

      # Set floating windows
      windowrulev2 = [
        "float, title:^(Open Folder)$"
        "float, title:^(Open File)$"
      ];

      exec-once = [
        "waybar"
        "hypridle"
        "swaync"
        "polkit-agent-helper-1"
        "systemctl start --user polkit-gnome-authentication-agent-1"
        ''hyprctl setcursor "McMojave Cursors" 24''
      ];

      env = [
        "GTK_THEME,WhiteSur-Dark"
        "GTK_ICON_THEME,WhiteSur-red-dark"
        "XDG_SESSION_TYPE,wayland"
        "QT_QPA_PLATFORM,wayland"
      ];

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        follow_mouse = true;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      bind = [
        # App Shortcuts
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive,"
        "$mod SHIFT, E, exit,"
        "$mod SHIFT, F, fullscreen, 1"  # Toggle full screen (1 keeps title bar)
        "$mod SHIFT, SPACE, togglefloating,"
        "$mod, SPACE, exec, wofi --show drun"
        ''$mod, SEMICOLON, exec, google-chrome-stable --profile-directory="Profile 1"''  # SandiaDev profile
        ''$mod SHIFT, SEMICOLON, exec, google-chrome-stable --profile-directory="Profile 2"''  # Kinektit profile
        "$mod SHIFT CTRL, SEMICOLON, exec, brave"
        "$mod, C, exec, code"

        # Window layouts
        "$mod, P, pseudo,"  # dwindle
        "$mod, J, togglesplit,"  # dwindle
        
        # Move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move window
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # Move workspace in a certain direction
        "$mod ALT CTRL, left, movecurrentworkspacetomonitor, l"
        "$mod ALT CTRL, right, movecurrentworkspacetomonitor, r"
        "$mod ALT CTRL, up, movecurrentworkspacetomonitor, u"
        "$mod ALT CTRL, down, movecurrentworkspacetomonitor, d"

        # Switch workspaces (with keypad alternative)
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod, KP_END, workspace, 1"
        "$mod, KP_DOWN, workspace, 2"
        "$mod, KP_NEXT, workspace, 3"
        "$mod, KP_LEFT, workspace, 4"
        "$mod, KP_BEGIN, workspace, 5"
        "$mod, KP_RIGHT, workspace, 6"
        "$mod, KP_HOME, workspace, 7"
        "$mod, KP_UP, workspace, 8"
        "$mod, KP_PRIOR, workspace, 9"
        "$mod, KP_INSERT, workspace, 10"

        # Move active window to a workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod SHIFT, KP_END, movetoworkspace, 1"
        "$mod SHIFT, KP_DOWN, movetoworkspace, 2"
        "$mod SHIFT, KP_NEXT, movetoworkspace, 3"
        "$mod SHIFT, KP_LEFT, movetoworkspace, 4"
        "$mod SHIFT, KP_BEGIN, movetoworkspace, 5"
        "$mod SHIFT, KP_RIGHT, movetoworkspace, 6"
        "$mod SHIFT, KP_HOME, movetoworkspace, 7"
        "$mod SHIFT, KP_UP, movetoworkspace, 8"
        "$mod SHIFT, KP_PRIOR, movetoworkspace, 9"
        "$mod SHIFT, KP_INSERT, movetoworkspace, 10"

        # Move active window but don't follow
        "$mod CTRL SHIFT, 1, movetoworkspacesilent, 1"
        "$mod CTRL SHIFT, 2, movetoworkspacesilent, 2"
        "$mod CTRL SHIFT, 3, movetoworkspacesilent, 3"
        "$mod CTRL SHIFT, 4, movetoworkspacesilent, 4"
        "$mod CTRL SHIFT, 5, movetoworkspacesilent, 5"
        "$mod CTRL SHIFT, 6, movetoworkspacesilent, 6"
        "$mod CTRL SHIFT, 7, movetoworkspacesilent, 7"
        "$mod CTRL SHIFT, 8, movetoworkspacesilent, 8"
        "$mod CTRL SHIFT, 9, movetoworkspacesilent, 9"
        "$mod CTRL SHIFT, 0, movetoworkspacesilent, 10"
        "$mod CTRL SHIFT, KP_END, movetoworkspacesilent, 1"
        "$mod CTRL SHIFT, KP_DOWN, movetoworkspacesilent, 2"
        "$mod CTRL SHIFT, KP_NEXT, movetoworkspacesilent, 3"
        "$mod CTRL SHIFT, KP_LEFT, movetoworkspacesilent, 4"
        "$mod CTRL SHIFT, KP_BEGIN, movetoworkspacesilent, 5"
        "$mod CTRL SHIFT, KP_RIGHT, movetoworkspacesilent, 6"
        "$mod CTRL SHIFT, KP_HOME, movetoworkspacesilent, 7"
        "$mod CTRL SHIFT, KP_UP, movetoworkspacesilent, 8"
        "$mod CTRL SHIFT, KP_PRIOR, movetoworkspacesilent, 9"
        "$mod CTRL SHIFT, KP_INSERT, movetoworkspacesilent, 10"

        # Scratchpad workspace
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Volume controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        " CTRL, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%+"
        " CTRL, XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        " CTRL, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        
        # Backlight controls
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"

        # Screen lock shortcut
        "$mod, L, exec, pidof hyprlock || (loginctl lock-session)"
      ];

      bindm = [
        # Move/resize windows with LMB/RMB and mod
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}