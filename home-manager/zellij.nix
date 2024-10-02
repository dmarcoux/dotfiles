# User configuration for zellij

{ pkgs-unstable, ... }:

{
  programs.zellij = {
    # Install zellij
    enable = true;
    package = pkgs-unstable.zellij;

    # Automatically start zellij whenever a zsh instance launches ― At least not for now... let's see later once I'm more used to zellij
    # enableZshIntegration = true;

    # Configure zellij
    settings = {
      theme = "solarized-light";
    };
  };
}
