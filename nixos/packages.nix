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
    pdftk
    peek
    rake
    shellcheck
    thunderbird-bin
    units
    universal-ctags
    xournal
    xsel
    zbar
    zip
  ];
}
