# User configuration for Elixir

{ config, ... }:

{
  home.sessionVariables = {
    # Location of the global IEx configuration file (.iex.exs)
    IEX_HOME = "${config.xdg.configHome}/elixir";
    # In IEx, use Neovim whenever opening files with `open` (see `h open` for details)
    ELIXIR_EDITOR = "nvim +__LINE__ __FILE__";
    # Persist history of the IEx (Elixir) and erl (Erlang) shells
    ERL_AFLAGS = "-kernel shell_history enabled";
  };

  # Configure IEx - https://hexdocs.pm/iex/IEx.html#configure/1
  xdg.configFile."elixir/.iex.exs".text = ''
    # Always print charlists as lists, so `[ 97, 98, 99 ]` is printed as `[ 97, 98, 99 ]`, not as `'abc'`
    IEx.configure(inspect: [ charlists: :as_lists ])
  '';
}
