# Configure KDE with both NixOS, and home-manager + plasma-manager options
# TODO: It would be nice to also combine all options for configs which are split between NixOS and home-manager

{ pkgs, pkgs-unstable, config, ... }:

{
  # NixOS options
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "plasmax11";
  services.desktopManager.plasma6.enable = true;

  # Exclude packages which I don't need
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # Text editor (I use Neovim for this...)
    kate
    # Default terminal for KDE
    konsole
    # Support for Wacom tablets
    wacomtablet
  ];

  # home-manager and plasma-manager options
  home-manager.users.dany = {
    # Autostart applications
    xdg.configFile."autostart/terminal.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Launch terminal
    # Somehow, this alacritty instance has a bigger font size due to the `Window Scale Factor` being wrong.
    # This issue started to happen when I upgraded to NixOS 24.05 and I don't know why... following alacritty instances
    # are fine. It's probably something with autorandr being executed just before alacritty. I don't want to use postswitch hooks
    # in autorandr to fix this issue... it's a lot of code/setup for something easily fix with an environment variable.
    #
    # TODO: It would be nice to instead rely on the home-manager config like this ''${hm-config.programs.alacritty.package}, where hm-config is the equivalent of config with its NixOS options
    # Exec=WINIT_X11_SCALE_FACTOR=1 ${pkgs.alacritty}/bin/alacritty
    Exec=alacritty
    # Launch once the KDE session manager is active and running
    X-KDE-autostart-condition=ksmserver
    '';

    xdg.configFile."autostart/browser.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Launch web browser
    Exec=chromium
    # Launch once the KDE session manager is active and running
    X-KDE-autostart-condition=ksmserver
    '';

    xdg.configFile."autostart/password_manager.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Launch password manager in the system tray
    Exec=1password --silent
    # Launch once the KDE session manager is active and running
    X-KDE-autostart-condition=ksmserver
    '';

    xdg.configFile."autostart/notes.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Launch notes app
    Exec=anytype
    # Launch once the KDE session manager is active and running
    X-KDE-autostart-condition=ksmserver
    '';

    programs.plasma = {
      enable = true;

      # All settings not specified explicitly in plasma-manager will be set to the default on next login.
      # This will automatically delete a lot of KDE configuration files on each generation.
      # It helps with having a truly declarative KDE configuration.
      overrideConfig = true;

      # Start with a "clean" / empty session; no applications from the previous session is restored
      session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
      # TODO: Look at other possible configuration options for `session`

      # TODO: Configure this
      # spectacle

      # TODO: Configure those rules taken from my i3 config
      # assign [class="^Alacritty$"] → $WS1
      # assign [class="^Code$"] → $WS1
      # assign [class="^jetbrains-.*"] → $WS1
      # assign [class="^obsidian$"] → $WS1
      # assign [class="^anytype$"] → $WS1

      # assign [class="^firefox$"] → $WS2
      # assign [class="^Slack$"] → $WS2
      # assign [class="^Chromium-browser$"] → $WS2

      # assign [class="^discord$"] → $WS3
      # assign [class="^bruno$"] → $WS3
      # assign [class="^Keymapp$"] → $WS3

      # assign [class="^Lollypop$"] → $WS5

      window-rules = [
        {
          description = "Maximize alacritty and assign it to first virtual desktop";
          match = {
            window-class = {
              # Matching exactly all classes. It's the list of `WM_CLASS(STRING)` from xprop's output
              value = "Alacritty Alacritty";
              type = "exact";
              match-whole = true;
            };
          };
          apply = {
            # Assign to the first virtual desktop
            desktops = {
              value = "Desktop_1";
            };
            # Maximize horizontally and vertically when it opens
            maximizehoriz = true;
            maximizevert = true;
          };
        }
        {
          description = "Maximize Chromium and assign it to second virtual desktop";
          match = {
            window-class = {
              # Matching exactly all classes. It's the list of `WM_CLASS(STRING)` from xprop's output
              value = "chromium-browser Chromium-browser";
              type = "exact";
              match-whole = true;
            };
          };
          apply = {
            # Assign to the second virtual desktop
            desktops = {
              value = "Desktop_2";
            };
            # Maximize horizontally and vertically when it opens
            maximizehoriz = true;
            maximizevert = true;
          };
        }
        {
          description = "Maximize Anytype and assign it to first virtual desktop";
          match = {
            window-class = {
              # Matching exactly all classes. It's the list of `WM_CLASS(STRING)` from xprop's output
              value = "anytype anytype";
              type = "exact";
              match-whole = true;
            };
          };
          apply = {
            # Assign to the first virtual desktop
            desktops = {
              value = "Desktop_1";
            };
            # Maximize horizontally and vertically when it opens
            maximizehoriz = true;
            maximizevert = true;
          };
        }

      ];

      # Prevent apps from remembering the position of their windows
      windows.allowWindowsToRememberPositions = false;

      # TODO: Configure this
      # workspace

      # TODO: This probably clashes with settings from nixos/keyboard.nix
      input.keyboard = {
        options = [
          # AltGr + Space produces a normal space instead of a non-breakable space
          "nbsp:none"
          # Alt + Space switches to the next keyboard layout
          "grp:alt_space_toggle"
        ];

        layouts = [
          {
            # Canadian Multilingual: https://kbdlayout.info/kbdcan
            displayName = "CAN";
            layout = "ca";
            variant = "multix";
          }
          {
            # German: https://kbdlayout.info/kbdgr
            displayName = "DEU";
            layout = "de";
          }
          {
            # US: https://kbdlayout.info/kbdus
            displayName = "USA";
            layout = "us";
          }
        ];

        # Switching the keyboard layout is global (Other options are for a given application, window or virtual desktop)
        switchingPolicy = "global";
      };

      krunner = {
        # Show KRunner in the center of the screen
        position = "center";
        # Launch KRunner with this shortcut
        shortcuts.launch = "Meta+d";
      };

      # TODO: Configure this...
      # kscreenlocker =

      panels = [
        {
          # Let the panel fill the entire width
          lengthMode = "fill";
          # Always show the panel, even for windows in fullscreen
          hiding = "none";
          # Display the panel at the top...
          floating = false;
          location = "top";
          # ... and on all screens
          screen = "all";

          # https://github.com/nix-community/plasma-manager/tree/trunk/modules/widgets
          widgets = [
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            {
              pager = {
                general = {
                  # Display the window outlines with their icons, but only for the panel's screen.
                  showWindowOutlines = true;
                  showApplicationIconsOnWindowOutlines = true;
                  showOnlyCurrentScreen = true;
                  # Do not display the virtual desktop name or number
                  displayedText = "none";
                };
              };
            }
            # Spacer between widgets
            "org.kde.plasma.panelspacer"
            {
              systemTray = {
                # Find the names of the various system tray entries in:
                # cat $XDG_CONFIG_HOME/plasma-org.kde.plasma.desktop-appletsrc
                # ls /run/current-system/sw/share/plasma/plasmoids
                items = {
                  # Do not show all items in the system tray
                  showAll = false;

                  shown = [
                    # Volume / Audio devices
                    "org.kde.plasma.volume"
                    # Network manager
                    "org.kde.plasma.networkmanagement"
                    # Current keyboard layout
                    "org.kde.plasma.keyboardlayout"
                    # Clipboard manager
                    "org.kde.plasma.clipboard"
                    # Power and battery
                    "org.kde.plasma.battery"
                    # Lock keys status (Caps Lock / Num Lock)
                    "org.kde.plasma.keyboardindicator"
                  ];

                  hidden = [
                    # Printers
                    "org.kde.plasma.printmanager"
                    # Media player
                    "org.kde.plasma.mediacontroller"
                    # Input method / Virtual keyboard
                    "org.kde.plasma.manage-inputmethod"
                    # Disks and device
                    "org.kde.plasma.devicenotifier"
                    # Notifications
                    "org.kde.plasma.notifications"
                    # Camera indicator - Shows whether any camera is in use
                    "org.kde.plasma.cameraindicator"
                    # Bluetooh
                    "org.kde.plasma.bluetooth"
                    # Brightness and color
                    "org.kde.plasma.brightness"
                  ];
                };
              };
            }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";

                date = {
                  # https://doc.qt.io/qt-6/qml-qtqml-qt.html#formatDateTime-method
                  format.custom = "ddd d, MMMM yyyy";
                };

                time = {
                  format = "24h";
                  showSeconds = "always";
                };
              };
            }
          ];
        }
      ];

      kwin = {
        virtualDesktops = {
          # When set, the number of virtual desktops is automatically detected and doesn't need to be specified
          names = [
            "Terminal"
            "Browser"
            "Communication"
            "Email"
            "Misc"
          ];
          rows = 1;
        };

        # Disable edge bariers, which would otherwise require additional travel distance for the cursor to cross screen edges.
        edgeBarrier = 0;

        effects = {
          # Disable the animation effects when switching between virtual desktops
          desktopSwitching.animation = "off";
          # Shaking the cursor makes it gradually grow. It eventually goes back to its normal size
          shakeCursor.enable = true;
        };

        # Enable and configure blue light filter to make the screen warmer based on location and time
        nightLight = {
          enable = true;

          # Use coordinates to figure out the sunset/sunrise times for the location defined below
          mode = "location";

          # Freiburg im Breisgau, DE
          # TODO: Check if this is needed. Maybe not setting this would automatically pick up the location.
          location = {
            latitude = "47.9990";
            longitude = "7.8421";
          };

          # Colour temperature to use at day/night, between 1000 and 25000 K
          temperature = {
            day = 5500;
            night = 3500;
          };
        };
      };

      hotkeys.commands."launch-terminal" = {
        name = "Launch terminal";
        key = "Meta+Enter";
        command = "alacritty";
      };

      # TODO: Configure this...
      # powerdevil

      # See the shortcuts in `System Settings - Shortcuts`
      #
      # If somehow a shortcut configured below isn't applied/working, it must be clashing with a default shortcut for a given action.
      # Fix this by setting the given action to an empty string, thus unbinding the shortcut.
      shortcuts = {
        # Session Management
        ksmserver = {
          "Lock Session" = [
            "Screensaver"
            "Meta+Shift+C"
          ];
        };

        kwin = {
          "Switch to Desktop 1" = "Meta+1";
          "Activate Task Manager Entry 1" = "";
          "Switch to Desktop 2" = "Meta+2";
          "Activate Task Manager Entry 2" = "";
          "Switch to Desktop 3" = "Meta+3";
          "Activate Task Manager Entry 3" = "";
          "Switch to Desktop 4" = "Meta+4";
          "Activate Task Manager Entry 4" = "";
          "Switch to Desktop 5" = "Meta+5";
          "Activate Task Manager Entry 5" = "";
          "Window to Desktop 1" = "Meta+!"; # Meta+Shift+1 on my keyboard layout
          "Window to Desktop 2" = "Meta+@"; # Meta+Shift+2 on my keyboard layout
          "Window to Desktop 3" = "Meta+#"; # Meta+Shift+3 on my keyboard layout
          "Window to Desktop 4" = "Meta+$"; # Meta+Shift+4 on my keyboard layout
          "Window to Desktop 5" = "Meta+%"; # Meta+Shift+5 on my keyboard layout
          "Switch to Window Below" = "Meta+J";
          "Switch to Window to the Left" = "Meta+H";
          "Switch to Window to the Right" = "Meta+L";
          "Switch to Window Above" = "Meta+K";
          "Switch Window Down" = "Meta+Shift+J";
          "Switch Window Left" = "Meta+Shift+H";
          "Switch Window Right" = "Meta+Shift+L";
          "Switch Window Up" = "Meta+Shift+K";
          "Expose" = "Meta+,";
          "Close Window" = "Meta+Shift+Esc"; # FIXME
        };
      };

      # $HOME/.config/
      configFile = {
        kdeglobals.General = {
          BrowserApplication = "chromium-browser.desktop";
          TerminalApplication = "alacritty";
          TerminalService = "Alacritty.desktop";
        };

        # TODO: Disable hot corner
        # https://github.com/ede1998/nix-config/blob/c3b40b7ba7e012d874cdf2b3c806e0ae20cbaed1/home-manager/plasma.nix#L151-L157
      };

      # $HOME/.local/share/
      dataFile = {
        # Dolphin - KDE's file manager
        "dolphin/view_properties/global/.directory" = {
          Settings = {
            # Show hidden files in Dolphin
            HiddenFilesShown = "true";
          };
        };
      };
    };
  };
}
