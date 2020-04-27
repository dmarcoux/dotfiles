# Packages to install without any specific configuration
# They are installed in the system profile
# Search for packages to install with `nix search package_name`

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
    atool
    exa
    jq
    mumble
    openresolv
    pdftk
    peek
    shellcheck
    stow
    thunderbird-bin
    units
    universal-ctags
    xcape
    xfce.xfce4-power-manager
    xournal
    xsel
    zbar
    zip
  ];
}
