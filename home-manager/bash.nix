{
  imports = [
    ./bash/autocompletion.nix
    ./bash/docker-podman.nix
    ./bash/general.nix
    ./bash/git.nix
    ./bash/github_cli.nix
    ./bash/nixos.nix
    ./bash/xmllint.nix
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # Space does not expand aliases
      bind '" ": magic-space'

      # Ctrl + Space expands all aliases
      bind '"\C- ": alias-expand-line'
    '';

    # If a new command line being added to the history list duplicates an older one,
    # the older command is removed from the list (even if it is not the previous event)
    historyControl = [ "ignoredups" "erasedups" ];
    # TODO: In zsh, I had this... maybe I can achieve this too in bash
    # Remove superfluous blanks from each command line being added to the history
    # setopt HIST_REDUCE_BLANKS

    shellAliases = {
      #----- Clipboard
      # Useful when piped with other commands
      cbc = "xsel --clipboard --input"; # Copy to clipboard
      cbp = "xsel --clipboard --output"; # Paste from clipboard
      # With fzf, select a command from the command history and put it without its numeral part in the clipboard
      cbcf = "fc -rl 1 | fzf --header='Select command to copy to clipboard' --tiebreak=index | sed -E \"s/^ *\([0-9]*\*\?\) *//g\" | cbc";
      #----- Confirmation
      # Prompt before overwrite
      mv = "mv --interactive";
      cp = "cp --interactive";
      ln = "ln --interactive";
      #----- Default options
      mkdir = "mkdir --parents --verbose"; # No error when directory already exists, more feedback
      ping = "ping -c 3"; # Ping with 3 packets
      #----- Safety nets
      # Prompt when removing more than 3 files at a time and do not remove '/'
      rm = "rm --interactive=once --preserve-root";
      # Fail to operate recursively on '/'
      chown = "chown --preserve-root";
      chmod = "chmod --preserve-root";
      chgrp = "chgrp --preserve-root";
      # This prevents issues with certain servers when SSH'ing like backspace not working and more...
      ssh = "TERM='xterm-256color' ssh";
      #----- Utilities
      # --data '{"abc":"123","def":"'my text'"}' or --data @filename (for some file containing JSON)
      curljson = "curl --verbose --header 'Content-Type: application/json' -X POST --data"; # See above for --data, then add  http://whatever.com
      # The password file (-rfbauth ~/.vnc/passwd) has to be setup with 'x11vnc -storepasswd'
      vncup = "x11vnc -forever -repeat -shared -viewonly -clip xinerama1 -rfbauth ~/.vnc/passwd";
    };
  };
}
