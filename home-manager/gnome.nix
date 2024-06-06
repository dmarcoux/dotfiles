# User configuration for GNOME

{ pkgs, lib, ... }:

{
  # Install dconf2nix (https://github.com/nix-community/dconf2nix)
  home.packages = [ pkgs.dconf2nix ];

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
  # This manual process can be simplified with https://github.com/nix-community/dconf2nix
  #
  # 1. dconf dump / > dconf.settings && dconf2nix -i dconf.settings -o dconf.nix
  # 2. Copy the settings I want to persist below in `dconf.settings`
  #
  dconf.settings = {
    ################################
    # Keyboard layout
    ################################

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

    ################################
    # Keyboard shortcuts
    ################################

    "org/gnome/desktop/wm/keybindings" = {
      # Switch to workspace X with Windows/Super key + {1,2,3,4}
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      # Move a window to workspace X with Shift + Windows/Super key + {1,2,3,4}
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      # Switch to another application from any workspace with (Shift) Windows/Super key + Tab
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      # Switch to next window in the current workspace with Windows/Super key + l
      switch-windows = [ "<Super>l" ];
      # Switch to previous window in the current workspace with Windows/Super key + h
      switch-windows-backward = [ "<Super>h" ];
      # All keybindings which are now disabled
      move-to-workspace-last = [];
      minimize = [];
    };

    "org/gnome/shell/keybindings" = {
      # All keybindings which are now disabled
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Lock the screen with Shift + Windows/Super key + c
      screensaver = [ "<Shift><Super>c" ];
      # Keybindings for media-keys to control music/video players
      next = [ "AudioNext" ];
      play = [ "AudioPlay" ];
      previous = [ "AudioPrev" ];
      stop = [ "AudioStop" ];
      volume-down = [ "AudioLowerVolume" ];
      volume-mute = [ "AudioMute" ];
      volume-up = [ "AudioRaiseVolume" ];
    };

    # Launch terminal with Windows/Super key + Enter
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Launch terminal";
    };

    ################################
    # UI
    ################################

    "org/gnome/desktop/interface" = {
      # Do not open the Activities Overview when the mouse cursor touches the top-left corner of the screen
      enable-hot-corners = false;
    };

    ################################
    # Notifications
    ################################

    # Disable notifications for the Lollypop music player
    "org/gnome/desktop/notifications/application/org-gnome-lollypop" = {
      application-id = "org.gnome.Lollypop.desktop";
      enable = false;
    };

    # Disable notifications for the Pulse Audio system tray
    "org/gnome/desktop/notifications/application/pasystray" = {
      application-id = "pasystray.desktop";
      enable = false;
    };

    ################################
    # Touchpad / Mouse
    ################################

    "org/gnome/desktop/peripherals/touchpad" = {
      # Use traditional scroll
      natural-scroll = false;
      two-finger-scrolling-enabled = true;
    };
  };
}
