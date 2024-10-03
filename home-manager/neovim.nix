# User configuration for neovim

{ pkgs, pkgs-unstable, config, ... }:

{
  programs.neovim = {
    # Install Neovim
    enable = true;
    # Use latest Neovim version available on nixos-unstable
    package = pkgs-unstable.neovim-unwrapped;

    # Set neovim as the default "basic/terminal" editor by setting the EDITOR environment variable
    defaultEditor = true;

    # Available plugins: https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-plugin-names
    # Any dot in the vim plugin names is replaced by a dash when listed below. Example: `fzf.vim` becomes `fzf-vim`.
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

      # Language Server Protocol
      nvim-lspconfig

      # Snippets
      vim-vsnip # nvim-cmp needs to have a snippets plugin

      # Autocompletion
      nvim-cmp # core plugin
      cmp-nvim-lsp # language server client completions
      cmp-buffer # buffer completions
      # TODO: This breaks git just like this issue: https://github.com/neovim/neovim/issues/20675
      #       This started to happen with the update from 2022-11-14 to 2023-03-12
      # cmp-vsnip # snippets completions (nvim-cmp needs to have a snippets plugin)

      # Highlight copied/yanked region
      vim-highlightedyank

      # Indicate added/modified/removed lines for current file (if it's managed by a version control system)
      vim-signify

      # Auto-pair brackets, parentheses, HTML tags, quotes, etc...
      # Automatically close certain structures like `if`, `do`, `def` in Ruby (and other languages)
      lexima-vim

      # Remove trailing whitespaces only on changed lines
      wstrip-vim

      #---------- Colorscheme Plugins
      # Solarized light and dark colorscheme
      nvim-solarized-lua

      #---------- Language Plugins
      # A collection of language plugins (150+ languages)
      vim-polyglot
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Main configuration
  xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/neovim/init.lua";

  # Minimal Neovim configuration for Git, like when doing `git commit --amend`
  # It duplicates some parts of the config above, but only what's needed.
  # TODO: Find a way to load this config into the main config.
  xdg.configFile."nvim/git.vim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home-manager/neovim/git.vim";
}
