# User configuration for fd

{ pkgs, ... }:

{
  programs.fd = {
    # Install fd
    enable = true;

    # Search for hidden files and directories
    hidden = true;

    # fd ignores anything matching this
    ignores = [
      ".git/"
    ];
  };
}
