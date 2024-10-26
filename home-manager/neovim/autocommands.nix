{
  # Autocommands which aren't directly related to a Neovim plugin
  # See `:help lua-guide-autocommands` for details
  programs.nixvim.autoCmd = [
    {
      desc = "Set options in Markdown files";
      event = [ "BufNewFile" "BufReadPost" ];
      pattern = [ "*.md" "gitcommit" ];
      callback = {
        __raw = ''
          function()
            -- Force Markdown type
            vim.opt.filetype = 'markdown'
            -- Wrap lines at 80 characters
            vim.opt_local.textwidth = 80
          end
        '';
      };
    }
    {
      desc = "When the quickfix window opens, move it the very bottom";
      event = "FileType"; # `qf` refers to the quickfix window (Search for `qf` in `:help filetypes`)
      pattern = "qf";
      callback = {
        __raw = ''
          function()
            vim.cmd('wincmd J') -- See `:help :wincmd` and `:help ^WJ`
          end
        '';
      };
    }
    {
      desc = "Highlight when yanking (copying) text";
      event = "TextYankPost";
      callback = {
        __raw = ''
          function()
            -- See `:help vim.highlight.on_yank()`
            vim.highlight.on_yank({ timeout = 1000 }) -- highlight for 1 second
          end
        '';
      };
    }
  ];
}
