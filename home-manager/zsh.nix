# User configuration for zsh

{ config, ... }:

{
  imports = [
    ./zsh/autocompletion.nix
    ./zsh/curl.nix
    ./zsh/docker-podman.nix
    ./zsh/general.nix
    ./zsh/git.nix
    ./zsh/history.nix
    ./zsh/github_cli.nix
    # TODO: Commented out since Mise with distrobox doesn't work, at least not with shims.
    #       It's annoying to always have to do `mise exec ...` on the NixOS host
    # ./zsh/mise.nix
    ./zsh/nixos.nix
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
      # This path is ~/.local/share/zsh/zsh_history
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
    initContent = ''
      # Add $HOME/.npm-packages to $PATH to install npm packages globally with:
      # npm config set prefix "$HOME/.npm-packages"
      # Add $HOME/.cargo/bin to $PATH to install cargo packages globally with:
      # cargo install
      # Add $HOME/.local/bin to $PATH to install pip packages globally with:
      # pipx install
      export PATH="${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.npm-packages/bin:${config.home.homeDirectory}/.cargo/bin:$PATH"

      # Do not print an error message like "zsh: no matches found: something?" if a command with a globbing expression doesn't match anything
      unsetopt nomatch
    '';
  };
}
