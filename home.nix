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
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    mesa-demos # testing hardware acceleration
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Jay Anderson";
    userEmail = "jay.anderson@sandiadev.com";
  };

  # starship - a customizable prompt for any shell
#   programs.starship = {
#     enable = true;
#     # custom settings
#     settings = {
#       add_newline = false;
#       aws.disabled = true;
#       gcloud.disabled = true;
#       line_break.disabled = true;
#     };
#   };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
#   programs.alacritty = {
#     enable = true;
#     # custom settings
#     settings = {
#       env.TERM = "xterm-256color";
#       font = {
#         size = 12;
#         draw_bold_text_with_bright_colors = true;
#       };
#       scrolling.multiplier = 5;
#       selection.save_to_clipboard = true;
#     };
#   };

#   programs.bash = {
#     enable = true;
#     enableCompletion = true;
#     # TODO add your custom bashrc here
#     bashrcExtra = ''
#       export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
#     '';

#     # set some aliases, feel free to add more or remove some
#     shellAliases = {
#       k = "kubectl";
#       urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
#       urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
#     };
#   };

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