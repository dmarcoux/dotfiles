# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
    atool
    binutils-unwrapped
    buku
    discord
    galculator
    gcc
    libreoffice
    mumble
    mupdf
    unstable.rust-analyzer
    openresolv
    openvpn
    p11-kit
    pdftk
    peek
    rake
    rustup
    shellcheck
    thunderbird-bin
    tigervnc
    units
    universal-ctags
    update-resolv-conf
    viewnior
    x11vnc
    xournal
    xsel
    zbar
    zip
  ];
}
