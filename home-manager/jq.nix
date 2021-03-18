# User configuration for jq

{ pkgs, ... }:

{
  # Install and configure jq
  programs.jq = {
    enable = true;
    # For details, see https://stedolan.github.io/jq/manual/#Colors
    # TODO: Remove colors once this PR is merged: https://github.com/nix-community/home-manager/pull/1870
    colors = {
      null    = "1;30";
      false   = "0;37";
      true    = "0;37";
      numbers = "0;37";
      strings = "0;32";
      arrays  = "1;37";
      objects = "1;37";
    };
  };

  # Aliases
  programs.zsh.initExtra = ''
    # Use a here string to pass some input directly to jq without having to work with a file
    # https://stackoverflow.com/questions/47105490/can-i-pass-a-string-variable-to-jq-not-the-file
    ealias jqs='jq <<<'
  '';
}
