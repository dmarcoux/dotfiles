# User configuration for yank

{ pkgs, ... }:

{
  # Install yank
  home.packages = [ pkgs.yank ];

  # Yank to the clipboard, as opposed to the default primary clipboard
  programs.zsh.shellAliases = { yank = "yank -- xsel --clipboard"; };
}
