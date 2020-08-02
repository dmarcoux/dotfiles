# User configuration for neovim

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraConfig = ''
      "-------------------- Plugins Settings
      "---------- fzf-vim
      " Non-recursive mapping in Normal and Visual modes for Ctrl+p to start fzf for files
      nnoremap <C-p> :Files<CR>
      vnoremap <C-p> :Files<CR>
      " Non-recursive mapping in Normal and Visual modes for Ctrl+n to start fzf for buffers
      nnoremap <C-n> :Buffers<CR>
      vnoremap <C-n> :Buffers<CR>
      "---------- vim-colors-solarized
      " Use light version of colorscheme
      set background=light

      " Set solarized colorscheme if it's installed (otherwise it fails silently)
      silent! colorscheme solarized

      "---------- tagbar
      " Open tagbar automatically for supported filetypes whenever opening a file
      autocmd FileType * nested :call tagbar#autoopen(0)
    '';

    # Available plugins: https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vim-plugins/vim-plugin-names
    plugins = with pkgs.vimPlugins; [
      #---------- Efficiency Plugins
      # Remaps . in a way that plugins can tap into it
      vim-repeat

      # Comment stuff out
      vim-commentary

      # Try to automatically adjust 'shiftwidth' and 'expandtab' based on the current file or its parents
      vim-sleuth

      # Lightning fast left-right movement
      quick-scope

      # Use fzf inside vim to open files and much more
      fzf-vim
      fzfWrapper

      # Change Vim working directory to project root (defined by the presence of a .git directory or anything else, it's configurable)
      vim-rooter

      # Browse the tags of the current file and get an overview of its structure
      tagbar

      #---------- Colorscheme Plugins
      # Solarized light and dark colorscheme
      vim-colors-solarized

      #---------- Language Plugins
      # A collection of language plugins (150+ languages)
      vim-polyglot
    ];

    viAlias = true;
    vimAlias = false; # TODO: Set to true once I got rid of vim
    vimdiffAlias = true;
  };
}
