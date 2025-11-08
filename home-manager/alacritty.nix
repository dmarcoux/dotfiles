# User configuration for alacritty

{ lib, ... }:

{
  programs.alacritty = {
    # Install alacritty
    enable = true;

    # Configure alacritty
    settings = {
      cursor = {
        # The cursor blinks every 750 milliseconds (this is the default interval)
        style = { blinking = "On"; };
      };
      font = { size = lib.mkForce 11.0; };
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
  programs.zsh.initContent = ''
    case "$TERM" in
      alacritty*|xterm*)
        precmd() { print -Pn '\e]2;zsh: %n@%~\a' } ;;
    esac
  '';
}
