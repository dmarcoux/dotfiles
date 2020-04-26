# User configuration for zsh

{ config, ... }:

{
  imports = [
    ./zsh/autocompletion.nix
    ./zsh/color_ls.nix
    ./zsh/git.nix
    ./zsh/history.nix
    ./zsh/prompt.nix
    ./zsh/ranger.nix
    ./zsh/aliases_setup.nix # Last imported file, but first to be processed (others depend on it)
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    history = {
      # Don't pollute home directory with zsh's history
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      # Share history among all shells
      share = true;
    };
    shellAliases = {
      #----- Clipboard
      # Useful when piped with other commands
      cbc = "xsel --clipboard --input"; # Copy to clipboard
      cbp = "xsel --clipboard --output"; # Paste from clipboard
      # With fzf, select a command from the command history and put it without its numeral part in the clipboard
      cbcf = "fc -rl 1 | fzf --tiebreak=index | sed 's/^ *\([0-9]*\*\?\) *//g' | cbc";
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
    };
  };
}
