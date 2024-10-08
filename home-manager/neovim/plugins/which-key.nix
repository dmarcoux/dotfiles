{
  programs.nixvim = {
    # Help with remembering my Neovim keymaps, by showing available keymaps in a pane as I type
    # https://github.com/folke/which-key.nvim/
    plugins.which-key = {
      enable = true;

      settings = {
        preset = "modern";
      };
    };
  };
}
