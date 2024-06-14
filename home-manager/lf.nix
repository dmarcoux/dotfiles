# User configuration for lf

{ config, ... }:

{
  programs.lf = {
    # Install lf
    enable = true;

    # Configure lf
    # https://github.com/gokcehan/lf/blob/master/doc.md
    extraConfig = ''
      ###############
      # Commands
      ###############
      # Modes
      # $ -> executes the shell command
      # % -> executes the shell command, piping its standard I/O to the bottom statline
      # ! -> executes the shell command and wait for a key press in the end
      # & -> executes the shell command asynchronously / in the background
      #
      # Arguments
      # $* -> pass all arguments to the shell command
      # $1, $2, $3, etc... -> pass the first, second, third, X argument to the shell command
      #
      # Environment Variables
      # https://github.com/gokcehan/lf/blob/master/doc.md#environment-variables

      # Open file with xdg-open
      cmd open $xdg-open $f

      # Open file with a given command (use `$*` to pass all command arguments)
      cmd open_with $$* $f

      # Put a file in the trash
      cmd trash %trash $fx

      # Create one/multiple directory(ies)
      cmd mkdir $mkdir $*

      # Extract archives
      cmd extract ''${{
          set -f # Disable pathname expansion
          atool --extract $f
      }}

      # Yank paths into the clipboard
      cmd yank-dirname $dirname -- "$f" | head -c-1 | xsel --clipboard --input
      cmd yank-basename $basename -a -- $fx | head -c-1 | xsel --clipboard --input
      cmd yank-basename-without-extension &basename -a -- $fx | rev | cut -d. -f2- | rev | head -c-1 | xsel --clipboard --input
      cmd yank-path $printf '%s' "$fx" | xsel --clipboard --input

      ###############
      # Mappings
      ###############

      map e # Remove default mapping for opening a file with $VISUAL

      map r push :open_with<space>

      map y # Remove defaut mapping for copy
      map y. yank-basename-without-extension
      map yd yank-dirname
      map yn yank-basename
      map yp yank-path
      map yy copy

      map p # Remove default mapping for paste
      map pp : paste; clear

      map d # Remove default mapping for cut
      map dd cut
      map dD delete
      map dT trash

      map g. cd ~/dotfiles
      map g/ cd /
      map gc cd ~/.config
      map gd cd ~/downloads
      map ge cd ~/ebooks
      map gmi cd ~/music-to-import
      map gmu cd ~/music
      map gpa cd ~/.config/password-store
      map gpi cd ~/pictures
      map gpr cd ~/projets
      map gt cd ${config.xdg.dataHome}/Trash
      map gv cd ~/videos

      ###############
      # Options
      ###############

      # Display 3 columns. Columns relative width: 12.5%,37.5%,50%
      set ratios '1:3:4'

      # Automatically refresh files every second
      set period 1

      # Show the size of files
      set info size

      # Show the number of files in a directory, instead of the total size of a directory
      set dircounts

      # Show 10 offset lines at all times at the top and bottom of the screen when scrolling
      set scrolloff 10

      # Show hidden files
      set hidden
    '';
  };
}
