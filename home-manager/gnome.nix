# User configuration for GNOME

{ lib, ... }:

{
  # With dconf, everything in GNOME can be configured.
  #
  # To find out how a specific setting namespace and key, start `dconf watch /` in a
  # terminal, then change the setting in the GNOME GUI. A `gsettings set (...)` command
  # can also be easily converted to the syntax `dconf` needs, for example:
  #
  #
  # gsettings set org.gnome.desktop.input-sources show-all-sources true
  #
  # turns into this for `dconf`
  #
  # /org/gnome/desktop/input-sources/show-all-sources
  #   true
  #
  # which can be converted to this in `dconf.settings`
  #
  #
  # "org/gnome/desktop/input-sources" = {
  #   show-all-sources = true;
  # };
  #
  # If unsure about how certain values are converted, refer to https://github.com/nix-community/dconf2nix
  # TODO: Try out https://github.com/nix-community/dconf2nix to ensure all my settings are declared below.
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      # Set the keyboard layout to Canadian (CSA), a multilingual and international version of the French (Canada) layout
      # It contains €, £ and more...
      sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "ca+multix" ]) ];
      # Custom keyboard layout options:
      # - Swap the Ctrl and Caps Lock keys
      # - AltGr + Space produces a normal space instead of a non-breakable space
      xkb-options = [ "ctrl:swapcaps" "nbsp:none" ];
      # TODO: AltGr + s for ß (this is an extra configuration which isn't available in xkb-options)
    };
  };
}
