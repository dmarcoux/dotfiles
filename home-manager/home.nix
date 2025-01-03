# User configuration with home-manager
# https://nix-community.github.io/home-manager/options.html

{
  # TODO: This list must be removed and ported to every host based on its needs. See how DM-Laptop-Dell-Precision-3581 does it with home-manager.nix
  # imports = [
  #   ./alacritty.nix
  #   ./autorandr.nix
  #   ./awscli.nix
  #   ./bat.nix
  #   ./beets.nix
  #   ./caffeine.nix
  #   ./cbatticon.nix
  #   ./direnv.nix
  #   ./dotnet.nix
  #   ./elixir.nix
  #   ./eza.nix
  #   ./fd.nix
  #   ./firefox.nix
  #   ./flameshot.nix
  #   ./fzf.nix
  #   ./git.nix
  #   ./gtk.nix
  #   ./i3.nix
  #   ./i3status.nix
  #   # I don't use Jetbrains IDEs right now, but I want to keep their configuration around if needed
  #   # ./jetbrains.nix
  #   ./jq.nix
  #   ./keyboard.nix
  #   ./lf.nix
  #   ./neovim.nix
  #   ./network-manager.nix
  #   ./pasystray.nix
  #   ./picom.nix
  #   ./playerctl.nix
  #   ./redshift.nix
  #   ./ripgrep.nix
  #   ./rofi.nix
  #   ./ruby.nix
  #   ./ssh.nix
  #   ./starship.nix
  #   ./tldr.nix
  #   ./udiskie.nix
  #   ./vscode.nix
  #   ./xcape.nix
  #   ./xdg.nix
  #   ./xorg.nix
  #   ./yank.nix
  #   ./yt-dlp.nix
  #   ./zellij.nix
  #   ./zsh.nix
  # ];

  # Enable home-manager to start the X session (otherwise graphical services are not started automatically)
  xsession.enable = true;

  # Set configuration defaults
  home = {
    homeDirectory = "/home/dany";
    # Switching to a higher state version typically requires performing some manual steps, such as data conversion or moving files
    # See release notes for state version changes: https://nix-community.github.io/home-manager/release-notes.html
    stateVersion = "24.11";
    username = "dany";
  };
}
