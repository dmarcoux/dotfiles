# User configuration for Ruby

{ pkgs, config, ... }:

{
  # Set the directory where binaries of Ruby gems are installed (which is also in $PATH)
  home.file.".gemrc".text = ''
    gem: --bindir /home/dany/bin
  '';
}
