# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # Infrastructure as Code tools
    ansible
    # Frontend to XRandR to manage multiple monitors
    arandr
    # Various commands to manage file archives of various types, such as tar and Zip archives
    atool
    # For DNS commands dig and nslookup
    bind
    # For the command `ar`, which creates, modifies, and extracts from archives
    bintools-unwrapped
    # Tool to help building and using APIs
    pkgs-unstable.bruno
    # eBook management
    calibre
    # Cross-platform build automation system
    cmake
    # CLI for development containers (https://containers.dev)
    pkgs-unstable.devcontainer
    # Audio and video conversion tool
    ffmpeg_6-headless
    # Ebook reader
    foliate
    # Simple calculator
    galculator
    # Compiler
    gcc
    # For the command make
    gnumake
    # Color picker
    gpick
    # Open source graph visualization software
    graphviz
    # Tool for glamorous shell scripts
    pkgs-unstable.gum
    # Configure (most) webcams
    guvcview
    # Interface to inotify, which can be used to monitor and act upon filesystem events
    inotify-tools
    # Office suite for spreadsheets, presentations and more...
    libreoffice
    # Share files with nearby devices
    localsend
    # Generate a database index of all files in my channels, then locate with nix-locate which packages contain these files
    nix-index
    # Formatter for Nix code
    nixfmt-classic
    # Note-taking app
    pkgs-unstable.obsidian
    # Manage resolv.conf for DNS settings
    openresolv
    # TLS/SSL and cryptography library
    openssl
    # VPN client
    openvpn
    # Cryptography for various applications
    p11-kit
    # For PCI commands like lspci and setpci
    pciutils
    # Edit PDF documents
    pdftk
    # Simple animated GIF screen recorder
    peek
    # Image editing software (and drawing)
    pinta
    # Install and run Python applications in isolated environments
    pipx
    # CLI program to copy/sync/move files and directories to and from many cloud services
    rclone
    # Batch rename files/directories according to a Perl expression
    rename
    # Beside work when I need to quickly test something in IRB, I also have Ruby to install gems without relying on the usual Nix way
    ruby
    # Command Line Interface for Scaleway
    pkgs-unstable.scaleway-cli
    # Terminal multiplexer, useful to perform long-running tasks
    screen
    # Static analysis tool for shell scripts
    shellcheck
    # Streaming service
    pkgs-unstable.spotify
    # Infrastructure as Code tool
    pkgs-unstable.terraform
    # For the `tree` command which shows the contents of the current directory as a tree
    tree
    # Traceroute to a host
    traceroute
    # CLI to the freedesktop.org trashcan
    trashy
    # Convert between two units of measure
    units
    # Generate an index file of language objects found in source files for programming languages (used in text editors)
    universal-ctags
    # CLI to create and manipulate disk partition tables
    unixtools.fdisk
    # RAR archive tool
    unrar
    # Extract files from Zip archives
    unzip
    # Script updating DNS settings pushed by OpenVPN servers
    update-resolv-conf
    # List USB devices with lsusb
    usbutils
    # Image viewer
    viewnior
    # Multimedia player
    vlc
    # Provides command for WHOIS (RFC 3912) protocol
    whois
    # Create bootable USB disks from Windows ISO images
    woeusb
    # Server for remote desktop viewers
    x11vnc
    # Execute commands when computer is idle for a specified amount of time
    xidlehook
    # Shell script to check $HOME for unwanted files and directories
    pkgs-unstable.xdg-ninja
    # Edit PDF documents and create digital signatures which can be applied to PDF documents
    xournalpp
    # Get and set the X selection (like changing the clipboard)
    xsel
    # Barcode and QR code reader
    zbar
    # Compress files in Zip archives
    zip
  ];
}
