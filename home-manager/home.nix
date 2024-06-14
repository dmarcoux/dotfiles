# User configuration with home-manager
# https://nix-community.github.io/home-manager/options.html

{ config, pkgs, nixos_options, ... }:

{
  imports = [
    ./alacritty.nix
    ./autorandr.nix
    ./bat.nix
    ./beets.nix
    ./cbatticon.nix
    ./dircolors.nix
    ./dotnet.nix
    ./elixir.nix
    ./eza.nix
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
    ./jetbrains.nix
    ./jq.nix
    ./keyboard.nix
    ./lf.nix
    ./neovim.nix
    ./network-manager.nix
    ./password-store.nix
    ./pasystray.nix
    ./picom.nix
    ./playerctl.nix
    ./redshift.nix
    ./ripgrep.nix
    ./rofi.nix
    ./ruby.nix
    ./scaleway.nix
    ./scripts.nix
    ./ssh.nix
    ./starship.nix
    ./tldr.nix
    ./udiskie.nix
    ./vscode.nix
    ./xcape.nix
    ./xdg.nix
    ./xorg.nix
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
    stateVersion = "24.05";
    username = "dany";
  };
}
