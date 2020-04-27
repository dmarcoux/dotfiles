# User configuration for fd

{ pkgs, ... }:

{
  # Install fd
  home.packages = [ pkgs.fd ];

  # Default options
  programs.zsh.shellAliases = { fd = "fd --hidden"; };

  # Configure fd
  home.file.".fdignore".text = ''
    # fd ignores anything matching this
    .git/
  '';
}
