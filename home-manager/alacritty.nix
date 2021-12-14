# User configuration for alacritty

{
  programs.alacritty = {
    # Install alacritty
    enable = true;

    # Configure alacritty
    settings = {
      colors = {
        primary = {
          background = "#fdf6e3";
          foreground = "#586e75";
        };
      };
      cursor = {
        # The cursor blinks every 750 milliseconds (this is the default interval)
        style = { blinking = "On"; };
      };
      key_bindings = [
        # Spawn new instance in the current directory with Ctrl+Shift+T
        { key = "T"; mods = "Control|Shift"; action = "SpawnNewInstance"; }
      ];
      # The mouse cursor is temporarily hidden when typing
      mouse = { hide_when_typing = true; };
    };
  };

  # colorsExtra = ''
  #   color0 = #073642
  #   color1 = #dc322f
  #   color2 = #859900
  #   color3 = #b58900
  #   color4 = #268bd2
  #   color5 = #d33682
  #   color6 = #2aa198
  #   color7 = #eee8d5
  #   color8 = #002b36
  #   color9 = #cb4b16
  #   color10 = #586e75
  #   color11 = #657b83
  #   color12 = #839496
  #   color13 = #6c71c4
  #   color14 = #93a1a1
  #   color15 = #fdf6e3
  # '';
  # foregroundBoldColor = "#073642";
  # foregroundColor = "#657b83";

  # FIXME: This was taken from termite. The code inside the case didn't change except for putting alacritty instead of termite
  # Set the terminal title to "zsh: $USERNAME@$PWD"
  programs.zsh.initExtra = ''
    case "$TERM" in
      alacritty*|xterm*)
        precmd() { print -Pn '\e];zsh: %n@%~\a' } ;;
    esac
  '';
}
