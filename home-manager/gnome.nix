# User configuration for GNOME

{ pkgs, lib, ... }:

{
  # Install dconf2nix (https://github.com/nix-community/dconf2nix)
  home.packages = ([
    pkgs.dconf2nix
  # Install GNOME extensions
  ]) ++ (with pkgs.gnomeExtensions; [
    # Move windows to a specific workspace when they open
    auto-move-windows
    # Tiled scrollable window manager
    paperwm
  ]);

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
    # Extensions
    ################################

    # To configure extensions through the UI, open the `Extensions` application.
    # Changes can then be declared here with dconf2nix as explained above.

    "org/gnome/shell" = {
      # Enable user extensions, which are installed at the top of this configuration file
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        auto-move-windows.extensionUuid
        paperwm.extensionUuid
      ];

      # Do not pin applications in the bottom/dash panel
      favorite-apps = [];
    };

    # Assign windows to a specific workspace
    "org/gnome/shell/extensions/auto-move-windows" = {
      # Format is: "Application:Workspace number"
      application-list = [
        "rider.desktop:1" # JetBrains Rider
        "Alacritty.desktop:1"
        "code.desktop:1" # Visual Studio Code

        "firefox.desktop:2"
        "slack.desktop:2"
        "chromium-browser.desktop:2"

        "bruno.desktop:3"
        "discord.desktop:3"

        "thunderbird.desktop:4"

        "org.gnome.Lollypop.desktop:5"
      ];
    };

    "org/gnome/shell/extensions/paperwm" = {
      animation-time = 0.0; # seconds
      # Enable topbar styling
      disable-topbar-styling = false;
      # Disable touchpad to control PaperWM
      gesture-enabled = false;
      # Set the size at which windows are shown during navigation, in relation to their actual size.
      minimap-scale = 0.25; # percentage in relation to 1.0
      # Open new windows to the right of the existing windows
      open-window-position = 0;
      # Translate to the selected window if it's not in view after exiting the GNOME overview
      overview-ensure-viewport-animation = 1;
      # Do not have a border around the selected window
      selection-border-size = 0;
      # Use the PaperWM color overlay for the GNOME top bar to show which window is selected and know its position in relation to other windows
      show-window-position-bar = true;
      # Replace GNOME workspace indicator with the one from PaperWM
      show-workspace-indicator = true;
      # Do not have margin between the windows and the screen edges
      horizontal-margin = 0;
      vertical-margin = 0;
      vertical-margin-bottom = 0;
      # Set the gap between windows
      window-gap = 10; # pixels
    };

    "org/gnome/shell/extensions/paperwm/workspaces" = {
      list = [ "1" "2" "3" "4" "5" ];
    };

    # Workspace names include Font Awesome icons
    "org/gnome/shell/extensions/paperwm/workspaces/1" = {
      index = 0;
      name = "1: ";
    };
    "org/gnome/shell/extensions/paperwm/workspaces/2" = {
      index = 1;
      name = "2:";
    };
    "org/gnome/shell/extensions/paperwm/workspaces/3" = {
      index = 2;
      name = "3: ";
    };
    "org/gnome/shell/extensions/paperwm/workspaces/4" = {
      index = 3;
      name = "4:";
    };
    "org/gnome/shell/extensions/paperwm/workspaces/5" = {
      index = 4;
      name = "5:";
    };

    ################################
    # Keyboard shortcuts
    ################################

    "org/gnome/desktop/wm/keybindings" = {
      # Switch to workspace X with Windows/Super key + {1,2,3,4,5}
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      # Move a window to workspace X with Shift + Windows/Super key + {1,2,3,4,5}
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      # Switch to another application from any workspace with (Shift) Windows/Super key + Tab
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      # All keybindings which are now disabled, some would be useful if I didn't use PaperWM
      move-to-workspace-last = [];
      minimize = [];
      toggle-maximized = []; # Toggle maximization of a window
      close = []; # Close a window
      switch-windows = []; # Switch to next window in the current workspace
      switch-windows-backward = []; # Switch to previous window in the current workspace

    };

    "org/gnome/shell/keybindings" = {
      # All keybindings which are now disabled
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      # Remove keybinding to restore the keyboard shortcuts
      restore-shortcuts = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      # See details of the custom keybindings below
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5/"
      ];
      # Lock the screen with Shift + Windows/Super key + c
      screensaver = [ "<Shift><Super>c" ];
      # By default, Windows/Super key + o is the keybinding to lock the display orientation
      # It's removed to prevent conflict with the custom `Launch rofi pass-otp` keyboard shortcut.
      rotate-video-lock-static = [ "XF86RotationLockToggle" ];
      # Keybindings for media-keys to control music/video players
      next = [ "AudioNext" ];
      play = [ "AudioPlay" ];
      previous = [ "AudioPrev" ];
      stop = [ "AudioStop" ];
      volume-down = [ "AudioLowerVolume" ];
      volume-mute = [ "AudioMute" ];
      volume-up = [ "AudioRaiseVolume" ];
    };

    # Launch rofi frontend to my pass usernames with Windows/Super key + u
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>u";
      command = "rofi -show pass-username";
      name = "Launch rofi pass-username";
    };

    # Launch rofi frontend to pass-otp for my two-factor authentication (2FA) codes with Windows/Super key + o
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>o";
      command = "rofi -show pass-otp";
      name = "Launch rofi pass-otp";
    };

    # Launch rofi frontend to pass for my passwords with Windows/Super key + p
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      binding = "<Super>p";
      command = "rofi -show pass";
      name = "Launch rofi pass";
    };

    # By default, Windows/Super key + p is the keybinding to switch monitors in the Mutter compositor.
    # It's removed to prevent conflict with `Launch rofi pass` above.
    "org/gnome/mutter/keybindings" = {
      switch-monitor = [];
    };

    # Launch rofi frontend to clipboard manager (matching clipboard entries case insensitively with `-i` option passed to dmenu)
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      binding = "<Super>c";
      command = "env CM_LAUNCHER=rofi clipmenu -i -p 'clipboard'";
      name = "Launch rofi clipmenu";
    };

    # With rofi, select an application to launch (It only lists applications shipping a .desktop file)
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom5" = {
      binding = "<Super>d";
      command = "rofi -show drun";
      name = "Launch rofi drun";
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      # Toggle maximization of a window
      toggle-maximize-width = [ "<Super>f" ];
      # Toggle fullscreen
      paper-toggle-fullscreen = [ "<Shift><Super>f" ];

      # Open a new instance of the active window
      new-window = [ "<Super>Return" ];

      # Merge the window to the right in the active column
      slurp-in = [ "<Super>t" ];
      # Expel the window at the bottom of the active column into its own column
      barf-out = [ "<Super>y" ];

      # Close the active window
      close-window = [ "<Shift><Super>q" ];

      # Switch to the window below/above (with wrap-around, so it goes back to the top/bottom)
      switch-down-loop = [ "<Super>j" ];
      switch-up-loop = [ "<Super>k" ];
      # Switch to the window to the left/right (with wrap-around, so it goes back to the right/left)
      switch-left-loop = [ "<Super>h" ];
      switch-right-loop = [ "<Super>l" ];

      # Move workspace to monitor up/down
      move-space-monitor-above = [ "<Control><Super>k" ];
      move-space-monitor-below = [ "<Control><Super>j" ];
      # Move workspace to monitor to the left/right
      move-space-monitor-left = [ "<Control><Super>h" ];
      move-space-monitor-right = [ "<Control><Super>l" ];

      # Move window to the left / right
      move-left = [ "<Shift><Super>h" ];
      move-right = [ "<Shift><Super>l" ];
      # Move window down/up
      move-up = [ "<Shift><Super>k" ];
      move-down = [ "<Shift><Super>j" ];

      # All keybindings which are now disabled
      switch-next = [ "" ];
      switch-previous = [ "" ];
      switch-down = [ "" ];
      switch-up = [ "" ];
      switch-left = [ "" ];
      switch-right = [ "" ];
      center-horizontally = [ "" ];
      take-window = [ "" ];
    };


    ################################
    # Default Applications
    ################################

    # Set alacritty as the default terminal
    "org/gnome/desktop/applications/terminal" = {
      exec = "alacritty";
    };

    ################################
    # UI
    ################################

    "org/gnome/desktop/interface" = {
      # Do not open the Activities Overview when the mouse cursor touches the top-left corner of the screen
      enable-hot-corners = false;
      # Show seconds in the top panel clock
      clock-show-seconds = true;
      # Show the day of the week in the top panel clock
      clock-show-weekday = true;
    };

    "org/gnome/mutter" = {
      # Do not automatically remove empty workspaces
      dynamic-workspaces = false;
      # Use workspaces only on the primary monitor
      workspaces-only-on-primary = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      # Set the number of workspaces to 5
      num-workspaces = 5;
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
