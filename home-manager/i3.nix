# User configuration for i3

{ pkgs, nixos_options, ... }:

{
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

      # Launch terminal
      exec alacritty

      # Launch web browser
      exec $BROWSER

      # If I'm not on holidays and today is a work day, launch Slack.
      #   "date +'%u'" prints out a number from 1 to 7 depending on the current day.
      #   1 to 4 are work days (Monday to Thursday), so if "date" outputs less than 5, it's a work day.
      exec test ! -f "$HOME/dotfiles/urlaub" && test $(date +'%u') -lt 5 && slack

      # If I'm not on holidays and today is a work day, launch Thunderbird.
      #   "date +'%u'" prints out a number from 1 to 7 depending on the current day.
      #   1 to 4 are work days (Monday to Thursday), so if "date" outputs less than 5, it's a work day.
      exec test ! -f "$HOME/dotfiles/urlaub" && test $(date +'%u') -lt 5 && thunderbird

      # Launch user activity monitor
      #   After 300 seconds (5 minutes):
      #     Lock the screen
      #     Enable screensaver and display power manager signaling (DPMS), which will become active after 600 more seconds (10 minutes)
      exec xidlehook --not-when-fullscreen --not-when-audio --timer 300 "${pkgs.xorg.xset}/bin/xset s on +dpms; slock" "${pkgs.xorg.xset}/bin/xset s off -dpms"
    '';
  };
}
