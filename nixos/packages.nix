# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # Deployment tool for work
    ansible
    # Frontend to XRandR to manage multiple monitors
    arandr
    # Various commands to manage file archives of various types, such as tar and Zip archives
    atool
    # For DNS commands dig and nslookup
    bind
    # For the command `ar`, which creates, modifies, and extracts from archives
    bintools-unwrapped
    # Manage eBook library
    calibre
    # Cross-platform build automation system
    cmake
    # Voice, video, and text chat
    discord
    # Keep Docker login credentials in pass
    docker-credential-helpers
    # IRC client through Matrix bridges
    element-desktop
    # Simple calculator
    galculator
    # Compiler
    gcc
    # For the command make
    gnumake
    # Static site generator
    unstable.hugo
    # Digital painting
    krita
    # Office suite for spreadsheets, presentations and more...
    libreoffice
    # Voice chat for work
    mumble
    # Expose localhost to the Internet (useful for web development)
    ngrok-2
    # Generate a database index of all files in my channels, then locate with nix-locate which packages contain these files
    nix-index
    # For coc.nvim, which provides auto-completion in Neovim
    unstable.nodejs-14_x
    # Manage resolv.conf for DNS settings
    openresolv
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
    # To run various rake tasks for work
    rake
    # Beside work when I need to quickly test something in IRB, I also have Ruby to install gems without relying on the usual Nix way
    ruby
    # Rust toolchain installer
    rustup
    # Static analysis tool for shell scripts
    shellcheck
    # Chat for work
    slack
    # Instant messaging
    signal-desktop
    # Collaborative cheatsheets for console commands
    tealdeer
    # Communication platform for work
    teams
    # Emails and agenda
    thunderbird-bin
    # Remote desktop viewer
    tigervnc
    # Convert between two units of measure
    units
    # Generate an index file of language objects found in source files for programming languages (used in text editors)
    universal-ctags
    # Extract files from Zip archives
    unzip
    # Script updating DNS settings pushed by OpenVPN servers
    update-resolv-conf
    # List USB devices with lsusb
    usbutils
    # Build and manage virtual machine (VM) environments
    vagrant
    # Image viewer
    viewnior
    # Multimedia player
    vlc
    # Provides command for WHOIS (RFC 3912) protocol
    whois
    # Server for remote desktop viewers
    x11vnc
    # Execute commands when computer is idle for a specified amount of time
    xidlehook
    # Edit PDF documents and create digital signatures which can be applied to PDF documents
    xournalpp
    # Get and set the X selection (like changing the clipboard)
    xsel
    # Barcode and QR code reader
    zbar
    # Offline documentation browser for software engineers
    zeal
    # Compress files in Zip archives
    zip
    # Chat often used by opensource projects
    zulip
  ];
}
