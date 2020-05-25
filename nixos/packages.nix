# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
    atool
    buku
    libreoffice
    mumble
    openvpn
    openresolv
    p11-kit
    pdftk
    peek
    rake
    shellcheck
    thunderbird-bin
    tigervnc
    units
    universal-ctags
    update-resolv-conf
    x11vnc
    xournal
    xsel
    zbar
    zip
  ];
}
