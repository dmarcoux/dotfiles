# User configuration for ripgrep

{ pkgs, config, ... }:

{
  # Intall ripgrep
  home.packages = [ pkgs.ripgrep ];

  # Set ripgrep's config path to avoid polluting the home directory
  home.sessionVariables = { RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/config"; };

  # Configure ripgrep
  xdg.configFile."ripgrep/config".text = ''
    # Set colors
    # Matches are blue
    --colors=match:fg:38,139,210
    # Line numbers are dark grey and bold
    --colors=line:fg:88,110,117
    --colors=line:style:bold
    # Paths are dark grey and bold
    --colors=path:fg:88,110,117
    --colors=path:style:bold

    # Search hidden files and directories
    --hidden

    # Searches case insensitively if the pattern is all lowercase. Search case sensitively otherwise.
    --smart-case

    # Global ignore file
    --ignore-file=${config.xdg.configHome}/ripgrep/ignore
  '';

  # ripgrep ignores anything matching this
  xdg.configFile."ripgrep/ignore".text = ''
    .git/

    *.swp

    # Minified files
    *.min.css
    *.css.map
    *.min.js
    *.js.map

    # Compiled files
    .sass-cache/
  '';
}
