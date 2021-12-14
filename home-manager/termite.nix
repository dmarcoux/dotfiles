# User configuration for termite

{
  # Install and configure termite
  programs.termite = {
    enable = true;
    audibleBell = false;
    backgroundColor = "#fdf6e3";
    clickableUrl = true;
    colorsExtra = ''
      color0 = #073642
      color1 = #dc322f
      color2 = #859900
      color3 = #b58900
      color4 = #268bd2
      color5 = #d33682
      color6 = #2aa198
      color7 = #eee8d5
      color8 = #002b36
      color9 = #cb4b16
      color10 = #586e75
      color11 = #657b83
      color12 = #839496
      color13 = #6c71c4
      color14 = #93a1a1
      color15 = #fdf6e3
    '';
    cursorBlink = "system";
    cursorColor = "#586e75";
    cursorShape = "block";
    dynamicTitle = true;
    foregroundBoldColor = "#073642";
    foregroundColor = "#657b83";
    mouseAutohide = true;
    optionsExtra = ''
      visible_bell = false
    '';
    scrollbackLines = 10000;
    scrollbar = "right";
    searchWrap = true;
  };

  # Set the terminal title to "zsh: $USERNAME@$PWD"
  # https://github.com/thestinger/termite/issues/1#issuecomment-5973525
  programs.zsh.initExtra = ''
    case "$TERM" in
      vte*)
        precmd() { print -Pn '\e];zsh: %n@%~\a' } ;;
    esac
  '';
}
