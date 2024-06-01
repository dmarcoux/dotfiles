# User configuration for alacritty

{
  programs.alacritty = {
    # Install alacritty
    enable = true;

    # Configure alacritty
    settings = {
      # "Solarized Light" taken from https://github.com/alacritty/alacritty-theme
      colors = {
        primary = {
          background = "#fdf6e3";
          foreground = "#586e75";
        };
        cursor = {
          text = "#fdf6e3";
          cursor = "#657b83";
        };
        normal = {
          black = "#073642";
          red = "#dc322f";
          green = "#859900";
          yellow = "#b58900";
          blue = "#268bd2";
          magenta = "#d33682";
          cyan = "#2aa198";
          white = "#eee8d5";
        };
        bright = {
          black = "#002b36";
          red = "#cb4b16";
          green = "#586e75";
          yellow = "#657b83";
          blue = "#839496";
          magenta = "#6c71c4";
          cyan = "#93a1a1";
          white = "#fdf6e3";
        };
      };
      cursor = {
        # The cursor blinks every 750 milliseconds (this is the default interval)
        style = { blinking = "On"; };
      };
      # A bit smaller than the default font size of 11.0
      font = { size = 10.0; };
      keyboard.bindings = [
        # Create new window in the current directory with Ctrl+Shift+T
        { key = "T"; mods = "Control|Shift"; action = "CreateNewWindow"; }
      ];
      # The mouse cursor is temporarily hidden when typing
      mouse = { hide_when_typing = true; };
    };
  };

  # Set the terminal title to "zsh: $USERNAME@$PWD"
  # Details at https://wiki.archlinux.org/title/Zsh#xterm_title
  programs.zsh.initExtra = ''
    case "$TERM" in
      alacritty*|xterm*)
        precmd() { print -Pn '\e]2;zsh: %n@%~\a' } ;;
    esac
  '';
}
