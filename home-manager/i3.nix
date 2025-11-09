# User configuration for i3
# Testing changes without rebuilding NixOS is possible with `i3-msg -t command SOME_I3_COMMAND` (example: `i3-msg -t command exec alacritty`)

{ pkgs, config, lib, ... }:

# To directly use base00, base01, base02, etc...
with config.lib.stylix.colors.withHashtag;

let
  # The modifier key is Windows/Meta key
  mod = "Mod4";

  # Workspaces (names include Font Awesome icons)
  ws1 = "1:  1";
  ws2 = "2:  2";
  ws3 = "3:  3";
  ws4 = "4:  4";
  ws5 = "5:  5";
in
{
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      bars = [
        {
          statusCommand = "${config.programs.i3status-rust.package}/bin/i3status-rs ${config.xdg.configHome}/i3status-rust/config-default.toml";

          position = "top";

          fonts = {
            names = [ config.stylix.fonts.monospace.name ];
            size = lib.mkForce 14.0;
          };

          # Overwrite some of the default colors set by stylix for i3's bar
          colors = config.stylix.targets.i3.exportedBarConfig.colors // {
            focusedWorkspace = {
              text = base00;
              background = base0B;
              border = base0B;
            };

            activeWorkspace = {
              text = base00;
              background = base0E;
              border = base0E;
            };

            urgentWorkspace = {
              text = base00;
              background = base08;
              border = base08;
            };
          };

          # Do not display workspace numbers
          workspaceNumbers = false;

          extraConfig = ''
            # The first available output will be used. It will be the primary output, otherwise the laptop's output.
            # Using trayOutput from Nix isn't possible since it only supports a single output
            tray_output primary
            tray_output eDP-1-1

            # Disable switching workspace by scrolling the mouse wheel up/down while the mouse cursor is over a workspace's icon
            bindsym button4 nop
            bindsym button5 nop
          '';
        }
      ];

      # Overwrite some of the default colors set by stylix for i3
      colors = {
        focused = { background = lib.mkForce base0B; border = lib.mkForce base0B; childBorder = lib.mkForce base0B; text = lib.mkForce base00; };
        focusedInactive = { background = lib.mkForce base0E; border = lib.mkForce base0E; childBorder = lib.mkForce base0E; text = lib.mkForce base00; };
        urgent = { background = lib.mkForce base08; border = lib.mkForce base08; childBorder = lib.mkForce base08; text = lib.mkForce base00; };
      };

      focus = {
        # Window focus doesn't follow mouse movements
        followMouse = false;
        # If a window is activated and it requests focus, it will be marked as urgent and not steal the focus
        newWindow = "urgent";
        # When in a container with several windows or child containers, the opposite window will be focused when trying
        # to move the focus over the edge of a container (and there are no other containers in that direction) — the focus wraps.
        wrapping = "yes";
      };

      fonts = {
        names = [config.stylix.fonts.monospace.name];
        size = lib.mkForce 13.0;
      };

      keybindings = {
        # Disable switching windows by scrolling the mouse wheel up/down while the mouse cursor is over a window's title
        "button4" = "nop";
        "button5" = "nop";

        # Restart i3 (preserves your layout/session, can be used to upgrade i3)
        "${mod}+Shift+r" = "restart";

        # Put the screen on standby (~1 second recovery time) to save power, lock the screen, then suspend the system
        # --release is needed when using slock (see https://github.com/i3/i3/issues/3298)
        "--release ${mod}+Shift+c" = "exec --no-startup-id xset dpms force standby && slock systemctl suspend --check-inhibitors=no";

        # Put the screen on standby (~1 second recovery time) to save power, then lock the screen
        # --release is needed when using slock (see https://github.com/i3/i3/issues/3298)
        "--release ${mod}+Shift+z" = "exec --no-startup-id xset dpms force standby && slock";

        # Start a terminal
        "${mod}+Return" = "exec alacritty";

        # Kill the focused window
        "${mod}+Shift+Escape" = "kill";

        # Start program launcher
        "${mod}+d" = "exec rofi -show drun"; # Only list applications shipping a .desktop file

        # Start window switcher
        "${mod}+s" = "exec rofi -show window";

        # Show 1Password's quick access
        #
        # In the quick access, these keyboard shorcuts are available (https://support.1password.com/keyboard-shortcuts/)
        # Ctrl + C | Copy the username or primary field of the selected item
        # Ctrl + Shift + C | Copy the password of the selected item
        # Ctrl + Alt + C | Copy the one-time password of the selected item
        # Alt + Enter | Open the website for the login in your browser and fill your username and password
        "${mod}+p" = "exec 1password --quick-access";

        # Start rofimoji (load default emojis and icons from Font Awesome)
        "${mod}+m" = "exec rofimoji --files emojis fontawesome6";

        # Start rofi frontend to clipboard manager (matching clipboard entries case insensitively with `-i` option passed to dmenu)
        "${mod}+c" = "exec CM_LAUNCHER=rofi clipmenu -i -p 'clipboard'";

        # Control media players with media keys
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioStop" = "exec playerctl stop";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # Control volume / mute
        # From https://wiki.archlinux.org/title/WirePlumber#Keyboard_volume_control
        "XF86AudioRaiseVolume" = "exec wpctl set-volume --limit 1.0 @DEFAULT_AUDIO_SINK@ 5%+"; # `1.0` is 100%
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        # Change focus
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move the focused window
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Move the focused workspace between monitors
        "${mod}+Control+h" = "move workspace to output left";
        "${mod}+Control+j" = "move workspace to output down";
        "${mod}+Control+k" = "move workspace to output up";
        "${mod}+Control+l" = "move workspace to output right";

        # Enter fullscreen mode for the focused container
        "${mod}+f" = "fullscreen toggle";

        # Change container layout (tabbed, toggle split)
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        # Focus the parent container
        "${mod}+Shift+a" = "focus parent";

        # Focus the child container
        "${mod}+a" = "focus child";

        # Switch to workspace
        "${mod}+1" = "workspace ${ws1}";
        "${mod}+2" = "workspace ${ws2}";
        "${mod}+3" = "workspace ${ws3}";
        "${mod}+4" = "workspace ${ws4}";
        "${mod}+5" = "workspace ${ws5}";

        # Move focused container to workspace
        "${mod}+Shift+1" = "move container to workspace ${ws1}";
        "${mod}+Shift+2" = "move container to workspace ${ws2}";
        "${mod}+Shift+3" = "move container to workspace ${ws3}";
        "${mod}+Shift+4" = "move container to workspace ${ws4}";
        "${mod}+Shift+5" = "move container to workspace ${ws5}";

        # Toggle the floating mode for the window
        "${mod}+Tab" = "floating toggle";
      };
      # Remove all default modes
      modes = {};

      modifier = mod;

      # Use LeftMouse+${mod} on a floating window to drag it to the wanted position
      # Use RightMouse+${mod} on a floating window to resize it
      floating.modifier = mod;

      # New containers on workspace starts in tabbed mode
      workspaceLayout = "tabbed";

      # Assign workspaces to specific outputs/screens
      workspaceOutputAssign = [
        {
          workspace = ws3;
          output = "primary";
        }
      ];

      # Default terminal
      terminal = "alacritty";

      # Commands to be executed at startup
      startup = [
        {
          # Load the first profile detected by autorandr to setup monitors, otherwise use the default profile (also called default... :D)
          # TODO: When this is executed, the screen flickers once. I wonder if running this in a systemd service when the graphical session starts would prevent this.
          command = "${pkgs.autorandr}/bin/autorandr --change --default default";
        }
        {
          # Make headphones the default audio output
          # 0 is the sink number. `analog-output-headphones` is the port. List sinks and their ports with `pactl list sinks`.
          command = "pacmd set-sink-port 0 analog-output-headphones";
        }
        {
          # Launch terminal
          # Somehow, this alacritty instance has a bigger font size due to the `Window Scale Factor` being wrong.
          # This issue started to happen when I upgraded to NixOS 24.05 and I don't know why... following alacritty instances
          # are fine. It's probably something with autorandr being executed just before alacritty. I don't want to use postswitch hooks
          # in autorandr to fix this issue... it's a lot of code/setup for something easily fix with an environment variable.
          command = "WINIT_X11_SCALE_FACTOR=1 alacritty";
        }
        {
          # Launch note-taking app
          command = "obsidian";
        }
        {
          # Launch web browser
          command = "$BROWSER";
        }
        {
          # Launch password manager in the system tray
          command = "1password --silent";
        }
        {
          # After 300 seconds (5 minutes) of inactivity (when audio isn't playing), put the
          # screen on standby (~1 second recovery time). After 30 more seconds, lock the screen
          # and suspend the system.
          #
          # `--detect-sleep` resets the inactivity timer once the system wakes up from suspend
          command = ''
            xidlehook --detect-sleep --not-when-audio \
            --timer 300 "xset dpms force standby" "" \
            --timer 30 "slock systemctl suspend --check-inhibitors=no" ""
          '';
          notification = false; # See --no-startup-id option description in the i3 user guide
        }
        # Disabled for now...
        # {
        #   # Launch Keymapp for my ZSA keyboard
        #   command = "keymapp";
        # }
        {
          # Launch kbdd to monitor which keyboard layout is active
          command = "${pkgs.kbdd}/bin/kbdd";
        }
      ];

      # Assign applications to workspaces to have them start on a specific workspace
      # https://i3wm.org/docs/userguide.html#assign_workspace
      # - To find the class for the assign statement:
      #   1. Start program
      #   2. Start xprop
      #   3. Click on program's window
      #   4. Get value of 'WM_CLASS(STRING)' from xprop's output
      assigns = {
        "${ws1}" = [
          { class = "^Alacritty$"; }
          { class = "^Code$"; }
          { class = "^jetbrains-.*"; }
          { class = "^obsidian$"; }
        ];

        "${ws2}" = [
          { class = "^firefox$"; }
          { class = "^Slack$"; }
          { class = "^Chromium-browser$"; }
        ];

        "${ws3}" = [
          { class = "^discord$"; }
          { class = "^bruno$"; }
          { class = "^Keymapp$"; }
        ];

        "${ws4}" = [
        ];

        "${ws5}" = [
          { class = "^Lollypop$"; }
          { class = "^Spotify$"; }
        ];
      };

      # Commands to execute on specific windows
      # https://i3wm.org/docs/userguide.html#for_window
      window.commands = [
        # Applications to start in floating mode
        { criteria.class = "^Galculator$"; command = "floating enable"; }
        { criteria.class = "^Vncviewer$"; command = "floating enable"; }
        { criteria.class = "^Yubico Authenticator$"; command = "floating enable"; }
        { criteria.class = "^Erlang$"; command = "floating enable"; } # Example of a window with the Erlang class is the Erlang Observer
        { criteria.class = "^Gpick$"; command = "floating enable"; }
        # Center floating windows in the workspace in which they appear
        { criteria.floating = true; command = "move position center"; }
        # Prevent certain applications from stealing focus
        { criteria.class = "^jetbrains-.*"; command = "no_focus"; }
      ];
    };
  };
}
