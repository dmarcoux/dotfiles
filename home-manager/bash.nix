{
  programs.bash = {
    enable = true;
    enableCompletion = true;

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
    };
  };
}
