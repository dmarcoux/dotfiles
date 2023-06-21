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
    # Music player
    audacious
    # For DNS commands dig and nslookup
    bind
    # For the command `ar`, which creates, modifies, and extracts from archives
    bintools-unwrapped
    # Cross-platform build automation system
    cmake
    # Voice, video, and text chat
    unstable.discord
    # Keep Docker login credentials in pass
    docker-credential-helpers
    # IRC client through Matrix bridges
    element-desktop
    # Functional, meta-programming aware language built on top of the Erlang VM. Useful wehn I need to quickly test something in IEx
    elixir_1_14
    erlangR25 # Only for the command `escript`, it's not necessary to explicitly install Erlang for Elixir
    # Elixir Language Server
    unstable.elixir_ls
    # CLI for https://exercism.org - Solve coding exercises and get mentored to gain true fluency in your chosen programming languages
    unstable.exercism
    # Ebook reader
    foliate
    # Simple calculator
    galculator
    # Compiler
    gcc
    # For the command make
    gnumake
    # Interface to inotify, which can be used to monitor and act upon filesystem events
    inotify-tools
    # Digital painting
    krita
    # Office suite for spreadsheets, presentations and more...
    libreoffice
    # Voice chat for work
    mumble
    # Expose localhost to the Internet (useful for web development)
    ngrok
    # Generate a database index of all files in my channels, then locate with nix-locate which packages contain these files
    nix-index
    # For coc.nvim, which provides auto-completion in Neovim
    unstable.nodejs-18_x
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
    # Official ProtonVPN app
    protonvpn-gui
    # CLI program to copy/sync/move files and directories to and from many cloud services
    rclone
    # Batch rename files/directories according to a Perl expression
    rename
    # Beside work when I need to quickly test something in IRB, I also have Ruby to install gems without relying on the usual Nix way
    ruby
    # Rust toolchain installer
    rustup
    # Command Line Interface for Scaleway
    unstable.scaleway-cli
    # Static analysis tool for shell scripts
    shellcheck
    # Chat for work
    slack
    # Ruby Language Server
    unstable.rubyPackages.solargraph
    # Client for Spotify
    spotify
    # Collaborative cheatsheets for console commands
    tealdeer
    # Communication platform for work
    teams
    # For the `tree` command which shows the contents of the current directory as a tree
    tree
    # Emails and agenda
    # Using unstable for the TbSync plugin to work (it needs at least Thunderbird 102.0.3)
    unstable.thunderbird-bin
    # Remote desktop viewer
    tigervnc
    # Traceroute to a host
    traceroute
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
  ];
}
