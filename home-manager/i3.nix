# User configuration for i3

{ pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true; # Enable i3 window manager to replace Xfwm
    # Empty settings are instead set below in extraConfig
    config = {
      bars = [];
      focus = {
        # Window focus doesn't follow mouse movements
        followMouse = false;
        # If a window is activated and it requests focus, it will be marked as urgent and not steal the focus
        newWindow = "urgent";
      };
      fonts = {
        names = ["DejaVu Sans Mono"];
        size = 13.0;
      };
      keybindings = {};
      modes = {};
      # Modifier key is the Windows Key
      modifier = "Mod4";
      # New containers on workspace starts in tabbed mode
      workspaceLayout = "tabbed";
    };
    extraConfig = ''
      #################
      # Variables
      #################

      # Modifier key is the Windows Key
      set $mod Mod4

      # Workspaces (names include Font Awesome icons)
      set $WS1 "1: 1"
      set $WS2 "2: 2"
      set $WS3 "3: 3"
      set $WS4 "4: 4"
      set $WS5 "5: 5"
      set $WS6 "6: 6"

      #################
      # Colorscheme
      #################

      # Solarized (Light) colors
      # Without alpha (for i3)
      set $black         #002B36
      set $grey          #839496
      set $dark_beige    #EEE8D5
      set $light_beige   #FDF6E3
      set $yellow        #B58900
      set $orange        #CB4B16
      set $red           #DC322F
      set $magenta       #D33682
      set $violet        #6C71C4
      set $blue          #268BD2
      set $cyan          #2AA198
      set $green         #859900

      # TYPE                   BORDER BACKGROUND TEXT
      client.focused           $green $green     $light_beige
      client.unfocused         $grey  $grey      $light_beige
      client.focused_inactive  $grey  $grey      $light_beige
      client.urgent            $red   $red       $light_beige

      #################
      # Settings
      #################

      # Put workspaces on specific screens
      workspace $WS3 output primary

      # Window focus doesn't follow mouse movements
      focus_follows_mouse no

      # Focus stays in the same parent container
      force_focus_wrapping yes

      # New containers on workspace starts in tabbed mode
      workspace_layout tabbed

      # Font for window titles. Will also be used by the bar unless a different font is used in the bar {} block below.
      font pango:DejaVu Sans Mono 13

      # Use LeftMouse+$mod on a floating window to drag it to the wanted position
      # Use RightMouse+$mod on a floating window to resize it
      floating_modifier $mod

      bar {
          status_command i3status
          position top
          font pango:DejaVu Sans Mono 13
          strip_workspace_numbers yes

          # The first available output will be used. It will be the primary output, otherwise the laptop's output.
          tray_output primary
          tray_output eDP-1-1

          # Disable switching workspace by scrolling the mouse wheel up/down
          bindsym button4 nop
          bindsym button5 nop

          colors {
              # Solarized (Light) colors
              background $light_beige
              statusline $grey
              separator  $grey

              # TYPE              BORDER      BACKGROUND  TEXT
              focused_workspace   $green      $green      $light_beige
              active_workspace    $violet     $violet     $light_beige
              inactive_workspace  $dark_beige $dark_beige $grey
              urgent_workspace    $red        $red        $light_beige
          }
      }

      #################
      # Applications
      #################

      # Assign applications to workspaces to have them start on a specific workspace
      # - To find the class for the assign statement:
      #   1. Start program
      #   2. Start xprop
      #   3. Click on program's window
      #   4. Get value of 'WM_CLASS(STRING)' from xprop's output
      assign [class="^Termite$"] → $WS1
      assign [class="^Alacritty$"] → $WS1
      assign [class="^Code$"] → $WS1
      assign [class="^Steam$"] → $WS1

      assign [class="^Firefox$"] → $WS2
      assign [class="^Slack$"] → $WS2

      assign [class="^discord$"] → $WS3
      assign [class="^Mumble$"] → $WS3
      assign [class="^Microsoft Teams - Preview"] → $WS3

      assign [class="^Thunderbird$"] → $WS4

      assign [class="^Chromium-browser$"] → $WS5
      assign [class="^MellowPlayer3$"] → $WS5

      # Applications to start in floating mode
      for_window [class="^Galculator$"] floating enable
      for_window [class="^Vncviewer$"] floating enable

      # Prevent Microsoft Teams from stealing focus
      no_focus [class="^Microsoft Teams"]

      # Center floating windows in the workspace in which they appear
      for_window [floating] move position center

      # Launch terminal
      exec alacritty

      # Launch web browser
      exec $BROWSER

      # On work days, launch Slack.
      #   "date +'%u'" prints out a number from 1 to 7 depending on the current day.
      #   1 to 4 are work days (Monday to Thursday), so if "date" outputs less than 5, it's a work day.
      exec test $(date +'%u') -lt 5 && slack

      # On work days, launch Microsoft Teams.
      #   "date +'%u'" prints out a number from 1 to 7 depending on the current day.
      #   1 to 4 are work days (Monday to Thursday), so if "date" outputs less than 5, it's a work day.
      exec test $(date +'%u') -lt 5 && teams

      # On work days, launch Thunderbird.
      #   "date +'%u'" prints out a number from 1 to 7 depending on the current day.
      #   1 to 4 are work days (Monday to Thursday), so if "date" outputs less than 5, it's a work day.
      exec test $(date +'%u') -lt 5 && thunderbird

      # Launch user activity monitor
      #   After 300 seconds (5 minutes):
      #     Lock the screen
      #     Enable screensaver and display power manager signaling (DPMS), which will become active after 600 more seconds (10 minutes)
      exec xidlehook --not-when-fullscreen --not-when-audio --timer 300 "${pkgs.xorg.xset}/bin/xset s on +dpms; slock" "${pkgs.xorg.xset}/bin/xset s off -dpms"

      #################
      # Key bindings
      #################

      # Restart i3 (preserves your layout/session, can be used to upgrade i3)
      bindsym $mod+Shift+r restart

      # Lock the screen
      # --release is needed when using slock (see https://github.com/i3/i3/issues/3298)
      bindsym --release $mod+Shift+C exec --no-startup-id "slock"

      # Start a terminal
      bindsym $mod+Return exec alacritty

      # Kill the focused window
      bindsym $mod+Shift+Escape kill

      # Start program launcher
      bindsym $mod+d exec rofi -show drun # Only list applications shipping a .desktop file

      # Start window switcher
      bindsym $mod+s exec rofi -show window

      # Start rofi frontend to pass for my usernames
      bindsym $mod+u exec rofi -show pass-username

      # Start rofi frontend to pass-otp for my two-factor authentication (2FA) codes
      bindsym $mod+o exec rofi -show pass-otp

      # Start rofi frontend to pass for my passwords
      bindsym $mod+p exec rofi -show pass

      # Start rofi frontend to clipboard manager (matching clipboard entries case insensitively with `-i` option passed to dmenu)
      bindsym $mod+c exec CM_LAUNCHER=rofi clipmenu -i -p 'clipboard'

      # Change focus
      bindsym $mod+h focus left
      bindsym $mod+j focus down
      bindsym $mod+k focus up
      bindsym $mod+l focus right

      # Move the focused window
      bindsym $mod+Shift+h move left
      bindsym $mod+Shift+j move down
      bindsym $mod+Shift+k move up
      bindsym $mod+Shift+l move right

      # Move the focused workspace between monitors
      bindsym $mod+Control+h move workspace to output left
      bindsym $mod+Control+j move workspace to output down
      bindsym $mod+Control+k move workspace to output up
      bindsym $mod+Control+l move workspace to output right

      # Enter fullscreen mode for the focused container
      bindsym $mod+f fullscreen toggle

      # Change container layout (tabbed, toggle split)
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split

      # Focus the parent container
      bindsym $mod+Shift+a focus parent

      # Focus the child container
      bindsym $mod+a focus child

      # Switch to workspace
      bindsym $mod+1 workspace $WS1
      bindsym $mod+2 workspace $WS2
      bindsym $mod+3 workspace $WS3
      bindsym $mod+4 workspace $WS4
      bindsym $mod+5 workspace $WS5
      bindsym $mod+6 workspace $WS6

      # Move focused container to workspace
      bindsym $mod+Shift+1 move container to workspace $WS1
      bindsym $mod+Shift+2 move container to workspace $WS2
      bindsym $mod+Shift+3 move container to workspace $WS3
      bindsym $mod+Shift+4 move container to workspace $WS4
      bindsym $mod+Shift+5 move container to workspace $WS5
      bindsym $mod+Shift+6 move container to workspace $WS6

      # Toggle the floating mode for the window
      bindsym $mod+Tab floating toggle

      # Resize focused container's width/height
      bindsym $mod+Left resize shrink width 5 px or 5 ppt
      bindsym $mod+Right resize grow width 5 px or 5 ppt
      bindsym $mod+Down resize shrink height 5 px or 5 ppt
      bindsym $mod+Up resize grow height 5 px or 5 ppt
    '';
  };
}
