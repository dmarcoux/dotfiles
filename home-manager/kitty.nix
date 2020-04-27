# User configuration for kitty

{
  # Install and configure kitty
  programs.kitty = {
    enable = true;
    font.name = "DejaVu Sans Mono 13";
    settings = {
      enable_audio_bell = false;
      cursor_blink_interval = 0; # Don't blink cursor
      scrollback_lines = 10000;
      # Solarized Light theme
      # https://github.com/kovidgoyal/kitty/issues/897
      background = "#fdf6e3";
      foreground = "#657b83";
      cursor = "#586e75";
      selection_background = "#475b62";
      selection_foreground = "#eae3cb";
      color0 = "#073642";
      color8 = "#002b36";
      color1 = "#dc322f";
      color9 = "#cb4b16";
      color2 = "#859900";
      color10 = "#586e75";
      color3 = "#b58900";
      color11 = "#657b83";
      color4 = "#268bd2";
      color12 = "#839496";
      color5 = "#d33682";
      color13 = "#6c71c4";
      color6 = "#2aa198";
      color14 = "#93a1a1";
      color7 = "#eee8d5";
      color15 = "#fdf6e3";
    };
  };
}
