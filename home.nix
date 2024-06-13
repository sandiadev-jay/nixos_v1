{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "jay";
  home.homeDirectory = "/home/jay";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # archives
    zip
    xz
    unzip
    p7zip
    unrar
    gnutar

    # web browsers
    firefox
    google-chrome
    brave
    
    # development tools
    vscode-fhs
    julia
    go
    nodejs_22
    cmake

    # wine
    wineWowPackages.waylandFull
    winetricks

    # design and artistic tools
    blender
    musescore
    gimp
    obs-studio
    renpy
    unityhub

    # configuration
    nwg-look

    # office tools
    libreoffice-qt6-still

    # media players
    vlc

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    htop  # system monitor
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    mesa-demos # testing hardware acceleration
    wev  # tool for identifying input keys
    xcur2png # converst cursors to PNG images
    wl-clipboard  # clipboard
    brightnessctl  # screen brightness controller

    # hyprland packages
    hyprdim
    hyprshot
    hyprpicker
    hyprcursor
    hyprlandPlugins.hy3
    xdg-desktop-portal-hyprland
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Jay Anderson";
    userEmail = "jay.anderson@sandiadev.com";
  };

  # Hyprland setup
  programs.waybar.enable = true;
  programs.hyprlock.enable = true;
  services.swaync.enable = true;
  programs.wofi.enable = true;
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hyprland.conf;


  # Hyprpaper config
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/jay/Documents/Backgrounds/kids_cloudcroft.jpg" ];
      wallpaper = [ ",/home/jay/Documents/Backgrounds/kids_cloudcroft.jpg" ];
    };
  };
  

  # Hypridle config
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";  # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session";  # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
      };
      listener = 
      let 
        batt_status = ''"$(cat /sys/class/power_supply/AC/online)"'';
        screen_on = "hyprctl dispatch dpms on";
        screen_off = "hyprctl dispatch dpms off";
        sleep = "systemctl suspend-then-hibernate";
      in
      [
        {
          timeout = 30;  # 0.5min.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";  # turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight";  # turn on keyboard backlight.
        }
        # Listeners on battery power
        {
          timeout = 120;  # 2min.
          on-timeout = ''[ ${batt_status} = "0" ] && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";  # monitor backlight restore.
        }
        {
          timeout = 180;  # 3min
          on-timeout = ''[ ${batt_status} = "0" ] && loginctl lock-session''; # lock screen when timeout has passed
        }
        {
          timeout = 210;  # 3.5min
          on-timeout = ''[ ${batt_status} = "0" ] && ${screen_off}'';  # screen off when timeout has passed
          on-resume = screen_on;  # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 600;  # 10min
          on-timeout = ''[ ${batt_status} = "0" ] && ${sleep}''; # suspend pc
        }
        # Listeners on plugged in power
        {
          timeout = 300;  # 5min
          on-timeout = ''[ ${batt_status} = "1" ] && brightnessctl -s set 10''; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r";  # monitor backlight restore.
        }
        {
          timeout = 600;  # 10min
          on-timeout = ''[ ${batt_status} = "1" ] && loginctl lock-session''; # lock screen when timeout has passed
        }
        {
          timeout = 630;  # 10.5min
          on-timeout = ''[ ${batt_status} = "1" ] && ${screen_off}'';  # screen off when timeout has passed
          on-resume = screen_on;  # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 1000;  # 30min
          on-timeout = ''[ ${batt_status} = "1" ] && ${sleep}''; # suspend pc
        }
      ];
    };
  };
  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}