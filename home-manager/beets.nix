# User configuration for beets

{ pkgs, config, ... }:

{
  programs.beets = {
    enable = true;
    # Even settings with their default value are listed below to understand what beets does
    # and if those values were to ever change, beets would still act the same way
    settings = {
      directory = "${config.xdg.userDirs.music}";

      import = { # When using `beet import`...
        # Write metadata tags to files
        write = true;

        # Copy files into the library directory, without altering the original files
        # All other import methods are disabled, since only one can be active
        copy = true;
        move = false;
        link = false;
        hardlink = false;
        reflink = false;

        # Whenever possible, ask if an import should be resumed
        resume = "ask";
      };

      # Path formats - Define how beets store files. For details, see https://beets.readthedocs.io/en/v1.6.0/reference/pathformat.html#available-values
      paths = {
        default = "$format/$albumartist/$album%aunique{}/$track $title"; # Default whenever another path format doesn't match
        singleton = "$format/Non-Album/$artist/$title"; # Single tracks
        comp = "$format/Compilations/$album%aunique{}/$track $title"; # Compilations
      };

      plugins = [
        # https://beets.readthedocs.io/en/stable/plugins/fetchart.html
        # Retrieve album art images from various sources on the web and stores them as image files
        "fetchart"
        # https://beets.readthedocs.io/en/stable/plugins/info.html
        # Provide the `info` command that dumps the current tag values for any file format supported by beets
        "info"
        # https://beets.readthedocs.io/en/stable/plugins/lastgenre.html
        # Fetch tags from Last.fm and assign them as genres to your albums and tracks
        "lastgenre"
        # https://beets.readthedocs.io/en/stable/plugins/missing.html
        # With the `missing` command, find and list which or how many tracks are missing in albums of my music collection
        "missing"
        # https://beets.readthedocs.io/en/stable/plugins/replaygain.html
        # Add support for ReplayGain, a technique for normalizing audio playback levels
        "replaygain"
      ];

      fetchart = {
        # Pick only trusted album art by ignoring filenames that do not contain one of the keywords in `cover_names`
        cautious = true;
        # Prioritize images containing words in this list
        cover_names = "cover front art album folder";
        # Try to fetch album art from various sources. They are searched in the given order
        sources = [
          # Use images inside the album folders, only if the image filenames match one of the names in `cover_names`
          "filesystem"
          # Use images from https://coverartarchive.org/ for an exact release of an album or its release group
          # See https://musicbrainz.org/doc/Release and https://musicbrainz.org/doc/Release_Group
          { coverart = "release releasegroup"; }
          # From iTunes Store
          "itunes"
        ];
      };

      replaygain = {
        # Use ffmpeg as the backend, but specify its path in command
        backend = "ffmpeg";
        command = "${pkgs.ffmpeg_6-headless}/bin/ffmpeg";
      };
    };
  };
}
