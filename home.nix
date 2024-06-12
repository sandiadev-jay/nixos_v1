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
  wayland.windowManager.hyprland.enable = true;
  services.hypridle.enable = true;  
  programs.waybar.enable = true;
  programs.hyprlock.enable = true;
  services.hyprpaper.enable = true;
  services.swaync.enable = true;
  programs.wofi.enable = true;

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