# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
    atool
    mumble
    openvpn
    openresolv
    p11-kit
    pdftk
    peek
    rake
    shellcheck
    thunderbird-bin
    units
    universal-ctags
    update-resolv-conf
    xournal
    xsel
    zbar
    zip
  ];
}
