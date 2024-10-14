{
  # Language Server Protocol (LSP)
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      # Elixir
      # https://github.com/elixir-lsp/elixir-ls
      elixirls = {
        enable = true;

        settings = {
          elixirLS = {
            # Disable Dialyzer until I'm more familiar with it...
            dialyzerEnabled = false;
          };
        };
      };

      # Go
      # https://github.com/golang/tools/tree/master/gopls
      gopls.enable = true;

      # Python
      # https://github.com/microsoft/pyright
      pyright.enable = true;
    };
  };
}
