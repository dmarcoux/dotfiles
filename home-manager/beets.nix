# User configuration for beets

{
  programs.beets = {
    enable = true;
    # Even settings with their default value are listed below to understand what beets does
    # and if those values were to ever change, beets would still act the same way
    settings = {
      directory = "~/music";

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
    };
  };
}
