{
  # Language Server Protocol (LSP)
  programs.nixvim.plugins.lsp = {
    enable = true;

    keymaps = {
      # Mappings for vim.diagnostic.<action> functions to be added when an LSP is attached.
      # https://neovim.io/doc/user/lsp.html#lsp-diagnostic
      diagnostic = { # Diagnostics are errors or warnings, see https://neovim.io/doc/user/diagnostic.html
        "<leader>el" = {
          action = "open_float";
          desc = "Show Diagnostic";
        };
        "<leader>ej" = {
          action = "goto_next";
          desc = "Next Diagnostic";
        };
        "<leader>ek" = {
          action = "goto_prev";
          desc = "Previous Diagnostic";
        };
      };

      # Mappings for vim.lsp.buf.<action> functions to be added when an LSP it attached
      # https://neovim.io/doc/user/lsp.html#lsp-buf
      lspBuf = {
        "<leader>k" = {
          action = "hover"; # https://neovim.io/doc/user/lsp.html#vim.lsp.buf.hover()
          desc = "Display information about the symbol under the cursor"; # in a floating window. The
          # floating window will be dismissed on cursor move. Jump into the floating window by using
          # the keymap again. In the floating window, all commands and mappings are available as usual,
          # except that "q" dismisses the window. You can scroll the contents the same as you would any
          # other buffer.
        };
        "<leader>r" = {
          action = "references"; # https://neovim.io/doc/user/lsp.html#vim.lsp.buf.references()
          desc = "List all references to the symbol under the cursor"; # in the quickfix window
        };
        "<leader>d" = {
          action = "definition"; # https://neovim.io/doc/user/lsp.html#vim.lsp.buf.definition()
          desc = "Jump to the definition of the symbol under the cursor";
        };
        "<leader>i" = {
          action = "implementation"; # https://neovim.io/doc/user/lsp.html#vim.lsp.buf.implementation()
          desc = "List all implementations for the symbol under the cursor"; # in the quickfix window
        };
        "<leader>t" = {
          action = "type_definition"; # https://neovim.io/doc/user/lsp.html#vim.lsp.buf.type_definition()
          desc = "Jump to the type definition of the symbol under the cursor";
        };
      };
    };

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
