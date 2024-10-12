# User configuration for zellij

{ pkgs-unstable, ... }:

{
  programs.zellij = {
    # Install zellij
    enable = true;
    package = pkgs-unstable.zellij;

    # Automatically start zellij whenever a bash/zsh instance launches ― At least not for now... let's see later once I'm more used to zellij
    # enableBashIntegration = true;
    # enableZshIntegration = true;
  };
}
