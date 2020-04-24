# User configuration for ripgrep

{ pkgs, config, ... }:

{
  # Intall ripgrep
  home.packages = [ pkgs.ripgrep ];

  # Set ripgrep's config path to avoid polluting the home directory
  home.sessionVariables = { RIPGREP_CONFIG_PATH = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ripgrep/config"; };
}
