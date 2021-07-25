# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    ansible
    arandr
    atool
    bind
    discord
    docker-credential-helpers
    element-desktop
    galculator
    gcc
    gnumake
    hicolor-icon-theme
    unstable.hugo
    krita
    libreoffice
    mumble
    mupdf
    ngrok-2
    nix-index
    unstable.nodejs-14_x
    openresolv
    openvpn
    p11-kit
    pdftk
    peek
    rake
    ruby
    shellcheck
    tealdeer
    teams
    thunderbird-bin
    tigervnc
    units
    universal-ctags
    unzip
    update-resolv-conf
    viewnior
    vlc
    whois
    x11vnc
    xidlehook
    xournal
    xsel
    zbar
    zip
  ];
}
