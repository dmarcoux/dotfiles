# User configuration for ranger

{ pkgs, ... }:

{
  # Install ranger without `highlight` to rely on `bat` for syntax highlighting in file previews
  home.packages = [ (pkgs.ranger.override { highlight = null; }) ];

  # Set default `bat` theme for syntax highlighting in file previews
  home.sessionVariables = { BAT_THEME = "Solarized (light)"; };

  # Configure rifle, the file launcher of ranger
  xdg.configFile."ranger/rifle.conf".text = ''
    # https://wiki.archlinux.org/index.php/Ranger#File_association
    # Using the flag f causes issues with vim as the colorscheme isn't working.
    # On top of this, I don't want to fork the application, making it run in the background

    # Choose the default application or the first application known to handle the file mimetype
    has xdg-open = xdg-open "$1"
  '';

  # Configuration of ranger
  xdg.configFile."ranger/rc.conf".text = ''
    # Display the number of files in each directory as soon as it's visible? Turning it off will still allow you to see the number of files after entering the directory.
    set automatically_count_files false

    # Display 3 columns. Columns relative width: 12.5%,37.5%,50%
    set column_ratios 1,3,4

    # Show hidden files (toggle with zh)
    set show_hidden true

    # Preview files and directories, collapse the rightmost column if there is nothing to preview
    set preview_files true
    set preview_directories true
    set collapse_preview true

    # Be aware of version control systems and display information
    set vcs_aware true

    # State of the three backends git, hg, bzr. The possible states are
    # disabled, local (only show local info), enabled (show local and remote
    # information).
    set vcs_backend_git enabled
    set vcs_backend_hg disabled
    set vcs_backend_bzr disabled

    # Reset history when restarting ranger
    set save_console_history false

    # Do not store the last directory in the bookmarks
    set save_backtick_bookmark false

    # Setting this to `true` helps in keeping bookmarks synchronized
    # between ranger instances, but I don't need this feature since I
    # never update bookmarks inside ranger itself. They are instead
    # configured with Nix.
    #
    # Save bookmarks only when ranger exits
    set autosave_bookmarks false
  '';

  # Custom ranger commands
  xdg.configFile."ranger/commands.py".text = ''
    # Please refer to commands_full.py for all the default commands and a complete
    # documentation.  Do NOT add them all here, or you may end up with defunct
    # commands when upgrading ranger.

    from __future__ import (absolute_import, division, print_function)

    # You always need to import ranger.api.commands here to get the Command class:
    from ranger.api.commands import Command
    from ranger.core.loader import CommandLoader

    # Based on https://wiki.archlinux.org/index.php/Ranger#Archives
    class extract(Command):
        def execute(self):
            """
            :extract

            Extract all files in the currently selected archive to a subdirectory (depends on atool)
            """
            import os

            current_archive = self.fm.thisfile

            def refresh(_):
                self.fm.thisdir.load_content()

            descr = "extracting: " + os.path.basename(current_archive.path)
            obj = CommandLoader(args=['aunpack'] + [current_archive.path], descr=descr)

            obj.signal_bind('after', refresh)
            self.fm.loader.add(obj)

    class toggle_flat(Command):
        """
        :toggle_flat

        Flattens or unflattens the directory view.
        """

        def execute(self):
            self.fm.thisdir.unload()

            if self.fm.thisdir.flat == 0:
                self.fm.thisdir.flat = -1
            else:
                self.fm.thisdir.flat = 0

            self.fm.thisdir.load_content()
  '';

  # List of bookmarks
  xdg.configFile."ranger/bookmarks".text = ''
    a:/home/dany/.config
    b:/home/dany/.config/password-store
    c:/home/dany/dotfiles
    d:/home/dany/downloads
    e:/home/dany/music
    f:/home/dany/pictures
    g:/home/dany/projets
    h:/home/dany/videos
    i:/home/dany/music-to-import
    j:/home/dany/ebooks
  '';

  programs.zsh.initExtra = ''
    # https://wiki.archlinux.org/index.php/Ranger#Preventing_nested_ranger_instances
    ranger() {
        if [ -z "$RANGER_LEVEL" ]; then
            /usr/bin/env ranger "$@"
        else
            exit
        fi
    }

    ealias ra="ranger"
  '';
}
