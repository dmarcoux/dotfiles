# User configuration for rofi

{ pkgs, config, ... }:

{
  programs.rofi = {
    enable = true;
    extraConfig = {
      # window: Window switcher
      # drun: Launch application (from list of .desktop files)
      modi = "window,drun";
      font = "${config.stylix.fonts.monospace.name} 14";
      show-icons = true;
      # Sort entries by matches
      sort = true;
      # Sort using fzf's strategy
      sorting-method = "fzf";
      # Use fuzzy matching algorithm
      matching = "fuzzy";
      # Unbind this as it is normally Control+k, which I need for vim keybindings
      kb-remove-to-eol = "";
      # Unbind these as they are normally Tab, which I need to select an entry
      kb-row-tab = "";
      kb-element-next = "";
      # Select entry
      kb-accept-entry = "Return,Tab";
      # Go to previous entry
      kb-row-up = "Control+k,Up";
      # Go to next entry
      kb-row-down = "Control+j,Down";
      # Quit rofi
      kb-cancel = "Escape";
      # Display rofi on the monitor with the currently focused window
      monitor = "-4";
    };
  };

  # Install rofimoji - Emoji, unicode and general character picker for rofi
  # https://github.com/fdw/rofimoji
  home.packages = [ pkgs.rofimoji ];
}
