# User configuration for GTK

{ config, ... }:

{
  gtk = {
    # Enable GTK 2/3 configuration
    enable = true;

    # Do not pollute $HOME with config files
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    # Set bookmarks in the sidebar of the GTK file browser (used in Firefox, Thunderbird, etc...)
    gtk3.bookmarks = [
      "file://${config.xdg.userDirs.download}"
      "file://${config.xdg.userDirs.documents}"
      "file://${config.xdg.userDirs.music}"
      "file://${config.xdg.userDirs.pictures}"
      "file://${config.xdg.userDirs.videos}"
      "file://${config.xdg.userDirs.extraConfig.XDG_AUDIO_DIR}"
      "file://${config.xdg.userDirs.extraConfig.XDG_PROJETS_DIR}"
      "file://${config.xdg.userDirs.extraConfig.XDG_TEMPORARY_DIR}"
      "file://${config.xdg.userDirs.extraConfig.XDG_EBOOKS_DIR}"
    ];
  };
}
