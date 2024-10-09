{
  programs.nixvim.plugins = {
    # Interface to tree-sitter, a parser generator tool and an incremental parsing library. Supports indentation, highlighting and folding.
    # https://github.com/tree-sitter/tree-sitter
    # https://github.com/nvim-treesitter/nvim-treesitter/
    treesitter = {
      enable = true;

      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    # With the help of treesitter, correctly set highlighting for languages contained in strings of a Home Manager configuration `nix` file.
    # https://github.com/calops/hmts.nvim
    hmts.enable = true;
  };
}
