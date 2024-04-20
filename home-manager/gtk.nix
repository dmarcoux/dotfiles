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
      "file:///home/dany/downloads"
      "file:///home/dany/documents"
      "file:///home/dany/music"
      "file:///home/dany/pictures"
      "file:///home/dany/videos"
      "file:///home/dany/audio"
      "file:///home/dany/projets"
      "file:///home/dany/tmp"
      "file:///home/dany/ebooks"
    ];
  };
}
