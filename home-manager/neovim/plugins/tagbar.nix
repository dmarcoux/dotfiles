{
  programs.nixvim = {
    # Browse the tags of the current file and get an overview of its structure
    # https://github.com/preservim/tagbar/
    plugins.tagbar.enable = true;

    autoCmd = [
      {
        desc = "Open tagbar automatically for supported filetypes whenever opening a file";
        event = "FileType";
        pattern = "*"; # All filetypes
        nested = true;
        callback = {
          __raw = ''
            function()
              vim.cmd('call tagbar#autoopen(0)') -- See `:help :tagbar-autoopen`
            end
          '';
        };
      }
    ];
  };
}
