# User configuration for Elixir

{
  home.sessionVariables = {
    # In IEx, use Neovim whenever opening files with `open` (see `h open` for details)
    ELIXIR_EDITOR = "nvim +__LINE__ __FILE__";
  };

  # Configure IEx - https://hexdocs.pm/iex/IEx.html#configure/1
  home.file.".iex.exs".text = ''
    # Always print charlists as lists, so `[ 97, 98, 99 ]` is printed as `[ 97, 98, 99 ]`, not as `'abc'`
    IEx.configure(inspect: [ charlists: :as_lists ])
  '';
}
