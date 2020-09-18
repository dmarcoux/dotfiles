# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
    atool
    bind
    binutils-unwrapped
    buku
    discord
    docker-credential-helpers
    galculator
    gcc
    libreoffice
    mumble
    mupdf
    unstable.nodePackages."@vue/cli"
    unstable.nodejs-14_x
    unstable.rust-analyzer
    openresolv
    openvpn
    p11-kit
    pdftk
    peek
    rake
    rustup
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
    whois
    x11vnc
    xidlehook
    xournal
    xsel
    zeal
    zbar
    zip
  ];
}
