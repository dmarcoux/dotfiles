# User configuration for Ruby

{ config, ... }:

{
  # Do not pollute $HOME with Ruby config files
  home.sessionVariables = {
    GEMRC = "${config.xdg.configHome}/ruby/gemrc";
  };

  # Set the directory where binaries of Ruby gems are installed (which is also in $PATH)
  xdg.configFile."ruby/gemrc".text = ''
    gem: --bindir ${config.home.homeDirectory}/bin
  '';
}
