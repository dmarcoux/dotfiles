# User configuration for lf

{ config, ... }:

{
  # Set default `bat` theme for syntax highlighting in file previews
  home.sessionVariables = { BAT_THEME = "Solarized (light)"; };

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

      # Every mapping starting with g is also used in fzf to quickly cd to those directories outside of lf
      map g. cd /home/dany/dotfiles
      map g/ cd /
      map gc cd ${config.xdg.configHome}
      map gd cd /home/dany/downloads
      map ge cd /home/dany/ebooks
      map gmi cd /home/dany/music-to-import
      map gmu cd /home/dany/music
      map gpa cd ${config.xdg.configHome}/password-store
      map gpi cd /home/dany/pictures
      map gpr cd /home/dany/projets
      map gt cd ${config.xdg.dataHome}/Trash
      map gv cd /home/dany/videos

      map m # Remove default mapping for mark-save
      map \' # Remove default mapping for mark-load (' has to be escaped since it's a special character)
      map \" # Remove default mapping for mark-remove (" has to be escaped since it's a special character)

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

      # Show hidden files (toggle with `zh`)
      set hidden
    '';
  };

  programs.zsh.initExtra = ''
    # Prevent nested lf instances, inspiration from https://wiki.archlinux.org/index.php/Ranger#Preventing_nested_ranger_instances
    lf() {
        if [ -z "$LF_LEVEL" ]; then
            /usr/bin/env lf "$@"
        else
            exit
        fi
    }

    ealias lf="lf"
  '';

}
