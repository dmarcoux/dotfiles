# Configuration for ranger

{ pkgs, ... }:

{
  environment.systemPackages = [(
    # Install ranger without syntax highlighting in file previews
    pkgs.ranger.override { highlight = null; }
  )];
}
