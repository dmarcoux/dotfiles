# User configuration for fd

{ pkgs, ... }:

{
  # Install fd
  home.packages = [ pkgs.fd ];

  # Default options
  programs.zsh.shellAliases = { fd = "fd --hidden"; };

  # Configure fd
  xdg.configFile."fd/ignore".text = ''
    # fd ignores anything matching this
    .git/
  '';

  # TODO NixOS 24.05 Use this configuration instead of what's defined above.
  #                  This won't pollute $HOME with `.fdignore`, instead fd's ignores will be under ~/.config/fd/ignore
  # programs.fd = {
  #   # Install fd
  #   enable = true;

  #   # Search for hidden files and directories
  #   hidden = true;

  #   # fd ignores anything matching this
  #   ignores = [
  #     ".git/"
  #   ];
  # };
}
