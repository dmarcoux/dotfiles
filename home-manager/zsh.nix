# User configuration for zsh

{ config, ... }:

{
  imports = [
    ./zsh/autocompletion.nix
    ./zsh/curl.nix
    ./zsh/docker.nix
    ./zsh/general.nix
    ./zsh/git.nix
    ./zsh/history.nix
    ./zsh/github_cli.nix
    ./zsh/nixos.nix
    ./zsh/osc.nix
    ./zsh/prompt.nix
    ./zsh/vnc.nix
    ./zsh/xmllint.nix
    ./zsh/aliases_setup.nix # Last imported file, but first to be processed (others depend on it)
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    # Don't pollute home directory with zsh's config (this path is relative to $HOME)
    dotDir = ".config/zsh";
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
      cbcf = "fc -rl 1 | fzf --tiebreak=index | sed -E \"s/^ *\([0-9]*\*\?\) *//g\" | cbc";
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
    initExtra = ''
      # Add $HOME/.npm-packages to $PATH to install npm packages globally with:
      # npm config set prefix "$HOME/.npm-packages"
      export PATH="$HOME/.npm-packages/bin:$PATH"
    '';
  };
}
