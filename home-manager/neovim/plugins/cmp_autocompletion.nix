{
  programs.nixvim = {
    # Display completion menu when there is one (menuone) or multiple (menu) suggestions and do not select a suggestion in the menu (noselect)
    opts.completeopt = [ "menu" "menuone" "noselect" ];

    plugins = {
      # Autocompletion engine
      # https://github.com/hrsh7th/nvim-cmp
      cmp = {
        enable = true;

        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          # Do not preselect a suggestion in the completion menu when it opens
          preselect = "cmp.PreselectMode.None";

          mapping = {
            # Select next suggestion with Ctrl + j
            "<C-j>" = "cmp.mapping.select_next_item()";
            # Select previous suggestion with Ctrl + k
            "<C-k>" = "cmp.mapping.select_prev_item()";
            # Trigger completion with Ctrl + Space
            "<C-Space>" = "cmp.mapping(cmp.mapping.complete(), { 'i', 'c' })";
            "<C-y>" = "cmp.config.disable"; # Disable default mapping for trigger completion
            # Close completion menu with Ctrl + e
            "<C-e>" = "cmp.mapping.close()";
            # Accept currently selected suggestion with Ctrl + l. With `select` to `false`, only accept explicitly selected items.
            "<C-l>" = "cmp.mapping.confirm({ select = false })";
          };

          sources = [
            { name = "path"; }
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "luasnip"; }
            { name = "buffer"; }
          ];
        };
      };
      # Autocompletion for LSPs
      # https://github.com/hrsh7th/cmp-nvim-lsp
      cmp-nvim-lsp.enable = true;
      # Display function signatures with the current parameter emphasized
      # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
      cmp-nvim-lsp-signature-help.enable = true;
      # Autocompletion for paths
      # https://github.com/hrsh7th/cmp-path
      cmp-path.enable = true;
      # Autocompletion for buffers
      # https://github.com/hrsh7th/cmp-buffer
      cmp-buffer.enable = true;
      # Snippets ― nvim-cmp requires the presense of a snippets plugin
      # https://github.com/L3MON4D3/LuaSnip
      luasnip.enable = true;
    };
  };
}
