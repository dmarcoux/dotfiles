{
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      # Have a single statusline at bottom of Neovim, instead of one for each individual window
      options.globalstatus = true;

      # Window bar for active and inactive windows. It is shown at the top of every window
      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      winbar = {
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            file_status = true; # Display if the file is readonly and was modified
            path = 1; # With 0, display only the filename. With 1, display the filename including its relative path from the current working directory or Git repository. With 2, display the filename, including its absolute path.
          }
        ];
      };

      inactive_winbar = {
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            file_status = true; # Display if the file is readonly and was modified
            path = 1; # With 0, display only the filename. With 1, display the filename including its relative path from the current working directory or Git repository. With 2, display the filename, including its absolute path.
          }
        ];
      };

      # Status line, shown at the bottom of every window
      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      # Y and Z are unused, at least for now...
      sections = {
        lualine_a = ["mode"]; # Vim mode
        lualine_b = ["branch"]; # Git branch
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            file_status = true; # Display if the file is readonly and was modified
            path = 1; # With 0, display only the filename. With 1, display the filename including its relative path from the current working directory or Git repository. With 2, display the filename, including its absolute path.
          }
          "diff"
        ];

        lualine_x = [
          "diagnostics"

          # Show active language server
          {
            __unkeyed.__raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            icon = " ";
            color.fg = "#ffffff";
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
      };
    };
  };
}
