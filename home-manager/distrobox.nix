# User configuration for Distrobox

{ pkgs-unstable, ... }:

{
  programs.distrobox = {
    enable = true;

    package = pkgs-unstable.distrobox;

    containers = {
      # TODO: Sadly, it doesn't work... at least not with shims. It's annoying to always have to do `mise exec ...` on the NixOS host.
      # With this, I can use Mise on NixOS just like if I was on Arch Linux
      arch-linux = {
        image = "docker.io/library/archlinux:latest";
        # Install Mise and export its binary to the NixOS host
        # Other packages are needed for Mise to correctly work
        additional_packages = "mise git base-devel";
        exported_bins = "/usr/sbin/mise";
        # Start the container immediately
        start_now = true;
      };
    };
  };
}
