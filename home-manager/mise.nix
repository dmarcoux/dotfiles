# User configuration for Mise

{ pkgs, pkgs-unstable, ... }:

{
  # Mise doesn't install pre-compiled binaries on NixOS, so it needs the following
  # dependencies to tools from source.
  # TODO: This still doesn't work to build Erlang from source
  home.packages = with pkgs; [
    # For Erlang / Elixir projects, see https://www.erlang.org/doc/system/install.html
    automake
    autoconf
    perl
    ncurses
    wxGTK32 # wxWidgets
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    package = pkgs-unstable.mise;
  };

  programs.zsh.initContent = ''
    ealias m='mise'
    ealias mr='mise run'
  '';
}
