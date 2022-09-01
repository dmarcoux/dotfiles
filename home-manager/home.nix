# User configuration with home-manager
# https://nix-community.github.io/home-manager/options.html

{ config, pkgs, unstable, nixos_options, ... }:

{
  imports = [
    (import ./neovim.nix { pkgs = pkgs; unstable = unstable; })
    (import ./starship.nix { unstable = unstable; })
    (import ./vscode.nix { unstable = unstable; })
    ../secrets/ssh/work.nix
    ./alacritty.nix
    ./autorandr.nix
    ./bat.nix
    ./cbatticon.nix
    ./dircolors.nix
    ./daps2docker.nix
    ./exa.nix
    ./fd.nix
    ./firefox.nix
    ./flameshot.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./gtk.nix
    (import ./i3.nix { pkgs = pkgs; nixos_options = nixos_options; })
    ./i3status.nix
    ./jq.nix
    ./keyboard.nix
    ./network-manager.nix
    ./password-store.nix
    ./pasystray.nix
    ./picom.nix
    ./playerctl.nix
    ./ranger.nix
    ./redshift.nix
    ./ripgrep.nix
    ./rofi.nix
    ./ruby.nix
    ./scripts.nix
    ./ssh.nix
    ./udiskie.nix
    ./xcape.nix
    ./xdg.nix
    ./yank.nix
    ./youtube-dl.nix
    ./zsh.nix
  ];

  # Enable home-manager to start the X session (otherwise graphical services are not started automatically)
  xsession.enable = true;

  # Set configuration defaults
  home = {
    homeDirectory = "/home/dany";
    # Switching to a higher state version typically requires performing some manual steps, such as data conversion or moving files
    # See release notes for state version changes: https://nix-community.github.io/home-manager/release-notes.html
    stateVersion = "22.05";
    username = "dany";
  };
}
