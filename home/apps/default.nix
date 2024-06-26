{ inputs, config, pkgs, ... }:

{
  # Packages that should be installed to the user profile
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
    # lynx  # CLI browser
    
    # development tools
    vscode-fhs
    julia
    go
    nodejs_22
    cmake
    python312
    python312Packages.conda
    python312Packages.pip

    # wine
    wineWowPackages.waylandFull
    winetricks

    # design and artistic tools
    blender
    musescore
    gimp
    obs-studio
    unityhub
    renpy

    # configuration
    nwg-look

    # office tools
    libreoffice-qt6-still
    pantheon.elementary-files

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
    nvtopPackages.full  # GPU monitoring
    gpustat  # GPU monitoring
    sysstat  # for iostat command
    lm_sensors # for `sensors` command
    ethtool  # for ethernet stuff
    pciutils # lspci
    powertop  # power use tool
    usbutils # lsusb
    mesa-demos # testing hardware acceleration
    wev  # tool for identifying input keys
    xcur2png # converst cursors to PNG images
    wl-clipboard  # clipboard
    brightnessctl  # screen brightness controller
    micro  # command line text editor

    # networking
    # samba4Full  # For file sharing between computers on the same network
    nmap  # For viewing devices connected to the network
    # nmcli - this is already activated, just a reminder for myself
    # bluetoothctl - this is already activate, just a reminder for myself
  ];
}