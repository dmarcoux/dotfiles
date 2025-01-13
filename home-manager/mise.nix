# User configuration for mise

{ pkgs-unstable, ... }:

{
  programs.mise = {
    # Install mise - https://mise.jdx.dev/
    enable = true;

    # mise is often updated, so use the package from unstable
    package = pkgs-unstable.mise;
  };
}
