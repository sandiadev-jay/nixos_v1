{ inputs, config, pkgs, ... }:

{
  # Ancillary service enablement
  # programs.waybar.enable = true;
  services.swaync.enable = true;
  programs.wofi.enable = true;

  # imports = [ inputs.hyprland.homeManagerModules.default ];
  # Hyprland setup
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    systemd.variables = ["--all"];
    xwayland.enable = true;

    # Hyprland plugins
    plugins = [
      inputs.hy3.packages.${pkgs.system}.hy3
    ];

    # Hyprland config 
    settings = {
      "$mod" = "SUPER";

      plugin = {
        hy3 = {
          # disable gaps when only one window is onscreen
          # 0 - always show gaps
          # 1 - hide gaps with a single window onscreen
          # 2 - 1 but also show the window border
          no_gaps_when_only = 1; # default: 0 

          # policy controlling what happens when a node is removed from a group,
          # leaving only a group
          # 0 = remove the nested group
          # 1 = keep the nested group
          # 2 = keep the nested group only if its parent is a tab group
          node_collapse_policy = 2; # default: 2

          # offset from group split direction when only one window is in a group
          group_inset = 10; # default: 10

          # if a tab group will automatically be created for the first window spawned in a workspace
          tab_first_window = false;

          # tab group settings
          tabs = {
            # height of the tab bar
            height = 15; # default: 15

            # padding between the tab bar and its focused node
            padding = 5; # default: 5

            # the tab bar should animate in/out from the top instead of below the window
            from_top = false; # default: false

            # rounding of tab bar corners
            rounding = 0; # default: 3

            # render the window title on the bar
            render_text = true; # default: true

            # center the window title
            text_center = true; # default: false

            # font to render the window title with
            text_font = "Sans"; # default: Sans

            # height of the window title
            text_height = 8; # default: 8

            # left padding of the window title
            text_padding = 3; # default: 3

            # active tab bar segment color
            "col.active" = "0xff32b4ff"; # default: 0xff32b4ff

            # urgent tab bar segment color
            "col.urgent" = "0xffff4f4f"; # default: 0xffff4f4f

            # inactive tab bar segment color
            "col.inactive" = "0x80808080"; # default: 0x80808080

            # active tab bar text color
            "col.text.active" = "0xff000000"; # default: 0xff000000

            # urgent tab bar text color
            "col.text.urgent" = "0xff000000"; # default: 0xff000000

            # inactive tab bar text color
            "col.text.inactive" = "0xff000000"; # default: 0xff000000
          };

          # autotiling settings
          autotile = {
            # enable autotile
            enable = false; # default: false

            # make autotile-created groups ephemeral
            ephemeral_groups = true; # default: true

            # if a window would be squished smaller than this width, a vertical split will be created
            # -1 = never automatically split vertically
            # 0 = always automatically split vertically
            # <number> = pixel height to split at
            trigger_width = 0; # default: 0

            # if a window would be squished smaller than this height, a horizontal split will be created
            # -1 = never automatically split horizontally
            # 0 = always automatically split horizontally
            # <number> = pixel height to split at
            trigger_height = 0; # default: 0

            # a space or comma separated list of workspace ids where autotile should be enabled
            # it's possible to create an exception rule by prefixing the definition with "not:"
            # workspaces = 1,2 # autotiling will only be enabled on workspaces 1 and 2
            # workspaces = not:1,2 # autotiling will be enabled on all workspaces except 1 and 2
            workspaces = "all"; # default: all
          };
        };
      };

      general = {
        gaps_in = 2;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "hy3";
        allow_tearing = false;
      };

      decoration = {
        rounding = 5;
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
          "windowsIn, 0, 7, myBezier"
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
      # master = {
      #   new_is_master = true;
      # };

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
        "1password"
        "waybar"
        "hypridle"
        "swaync"
        "polkit-agent-helper-1"
        "systemctl start --user polkit-gnome-authentication-agent-1"
        ''hyprctl setcursor "McMojave-cursors" 24''
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
        workspace_swipe_fingers = 4;
        workspace_swipe_forever = false;
        workspace_swipe_cancel_ratio = 0.4;
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
        "$mod, left, hy3:movefocus, l"
        "$mod, right, hy3:movefocus, r"
        "$mod, up, hy3:movefocus, u"
        "$mod, down, hy3:movefocus, d"

        # Move window
        "$mod SHIFT, left, hy3:movewindow, l"
        "$mod SHIFT, right, hy3:movewindow, r"
        "$mod SHIFT, up, hy3:movewindow, u"
        "$mod SHIFT, down, hy3:movewindow, d"

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
        "$mod SHIFT, 1, hy3:movetoworkspace, 1, follow"
        "$mod SHIFT, 2, hy3:movetoworkspace, 2, follow"
        "$mod SHIFT, 3, hy3:movetoworkspace, 3, follow"
        "$mod SHIFT, 4, hy3:movetoworkspace, 4, follow"
        "$mod SHIFT, 5, hy3:movetoworkspace, 5, follow"
        "$mod SHIFT, 6, hy3:movetoworkspace, 6, follow"
        "$mod SHIFT, 7, hy3:movetoworkspace, 7, follow"
        "$mod SHIFT, 8, hy3:movetoworkspace, 8, follow"
        "$mod SHIFT, 9, hy3:movetoworkspace, 9, follow"
        "$mod SHIFT, 0, hy3:movetoworkspace, 10, follow"
        "$mod SHIFT, KP_END, hy3:movetoworkspace, 1, follow"
        "$mod SHIFT, KP_DOWN, hy3:movetoworkspace, 2, follow"
        "$mod SHIFT, KP_NEXT, hy3:movetoworkspace, 3, follow"
        "$mod SHIFT, KP_LEFT, hy3:movetoworkspace, 4, follow"
        "$mod SHIFT, KP_BEGIN, hy3:movetoworkspace, 5, follow"
        "$mod SHIFT, KP_RIGHT, hy3:movetoworkspace, 6, follow"
        "$mod SHIFT, KP_HOME, hy3:movetoworkspace, 7, follow"
        "$mod SHIFT, KP_UP, hy3:movetoworkspace, 8, follow"
        "$mod SHIFT, KP_PRIOR, hy3:movetoworkspace, 9, follow"
        "$mod SHIFT, KP_INSERT, hy3:movetoworkspace, 10, follow"

        # Move active window but don't follow
        "$mod CTRL SHIFT, 1, hy3:movetoworkspace, 1"
        "$mod CTRL SHIFT, 2, hy3:movetoworkspace, 2"
        "$mod CTRL SHIFT, 3, hy3:movetoworkspace, 3"
        "$mod CTRL SHIFT, 4, hy3:movetoworkspace, 4"
        "$mod CTRL SHIFT, 5, hy3:movetoworkspace, 5"
        "$mod CTRL SHIFT, 6, hy3:movetoworkspace, 6"
        "$mod CTRL SHIFT, 7, hy3:movetoworkspace, 7"
        "$mod CTRL SHIFT, 8, hy3:movetoworkspace, 8"
        "$mod CTRL SHIFT, 9, hy3:movetoworkspace, 9"
        "$mod CTRL SHIFT, 0, hy3:movetoworkspace, 10"
        "$mod CTRL SHIFT, KP_END, hy3:movetoworkspace, 1"
        "$mod CTRL SHIFT, KP_DOWN, hy3:movetoworkspace, 2"
        "$mod CTRL SHIFT, KP_NEXT, hy3:movetoworkspace, 3"
        "$mod CTRL SHIFT, KP_LEFT, hy3:movetoworkspace, 4"
        "$mod CTRL SHIFT, KP_BEGIN, hy3:movetoworkspace, 5"
        "$mod CTRL SHIFT, KP_RIGHT, hy3:movetoworkspace, 6"
        "$mod CTRL SHIFT, KP_HOME, hy3:movetoworkspace, 7"
        "$mod CTRL SHIFT, KP_UP, hy3:movetoworkspace, 8"
        "$mod CTRL SHIFT, KP_PRIOR, hy3:movetoworkspace, 9"
        "$mod CTRL SHIFT, KP_INSERT, hy3:movetoworkspace, 10"

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

        # Hy3 binds
        "$mod, V, hy3:makegroup, v,"
        "$mod, B, hy3:makegroup, h,"
        "$mod, T, hy3:makegroup, tab,"
        "$mod, A, hy3:changefocus, raise"
        "$mod SHIFT, A, hy3:changefocus, lower"
        "$mod, J, hy3:changegroup, opposite"  # Hy3
        "$mod SHIFT, T, hy3:changegroup, toggletab"
      ];

      bindm = [
        # Move/resize windows with LMB/RMB and mod
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindn = [
        ", mouse:272, hy3:focustab, mouse"
        ", mouse_down, hy3:focustab, l, require_hovered"
        ", mouse_up, hy3:focustab, r, require_hovered"
      ];
    };
  };
}