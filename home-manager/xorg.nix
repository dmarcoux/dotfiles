# User configuration for X.Org

{ config, ... }:

{
  home.sessionVariables = {
    # Do not pollute $HOME with config files
    XCOMPOSECACHE="${config.xdg.cacheHome}/X11/xcompose";
  };
}
