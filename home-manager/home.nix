# User configuration with home-manager
# https://nix-community.github.io/home-manager/options.html

{ config, pkgs, unstable, nixos_options, ... }:

{
  imports = [
    (import ./neovim.nix { pkgs = pkgs; unstable = unstable; })
    (import ./starship.nix { unstable = unstable; })
    (import ./vscode.nix { unstable = unstable; })
    ./alacritty.nix
    ./autorandr.nix
    ./bat.nix
    ./beets.nix
    ./cbatticon.nix
    ./dircolors.nix
    ./daps2docker.nix
    ./elixir.nix
    ./exa.nix
    ./fd.nix
    ./firefox.nix
    ./flameshot.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./gtk.nix
    ./helix.nix
    (import ./i3.nix { pkgs = pkgs; nixos_options = nixos_options; })
    ./i3status.nix
    ./jq.nix
    ./keyboard.nix
    ./network-manager.nix
    ./open-build-service.nix
    ./password-store.nix
    ./pasystray.nix
    ./picom.nix
    ./playerctl.nix
    ./ranger.nix
    ./redshift.nix
    ./ripgrep.nix
    ./rofi.nix
    ./ruby.nix
    ./scaleway.nix
    ./scripts.nix
    ./ssh.nix
    ./udiskie.nix
    ./xcape.nix
    ./xdg.nix
    ./yank.nix
    ./yt-dlp.nix
    ./zsh.nix
  ];

  # Enable home-manager to start the X session (otherwise graphical services are not started automatically)
  xsession.enable = true;

  # Set configuration defaults
  home = {
    homeDirectory = "/home/dany";
    # Switching to a higher state version typically requires performing some manual steps, such as data conversion or moving files
    # See release notes for state version changes: https://nix-community.github.io/home-manager/release-notes.html
    stateVersion = "23.05";
    username = "dany";
  };
}
