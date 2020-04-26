# Set the LS_COLORS environment variable, used by the command ls

{ config, ... }:

{
  programs.zsh.initExtra = ''
    eval $(dircolors --bourne-shell "${config.xdg.configHome}/dircolors/dircolors.ansi-light")
  '';
}
