# User configuration for Neovim

{ pkgs, pkgs-unstable, config, ... }:

{
  imports = [
    ./neovim/autocommands.nix
    ./neovim/plugins/cmp_autocompletion.nix
    ./neovim/plugins/fzf-vim.nix
    ./neovim/plugins/lsp.nix
    ./neovim/plugins/lualine.nix
    ./neovim/plugins/tagbar.nix
    ./neovim/plugins/treesitter.nix
    ./neovim/plugins/vim-rooter.nix
    ./neovim/plugins/which-key.nix
    ./neovim/plugins/wstrip.nix
  ];

  # Install and configure Neovim with Nix - https://github.com/nix-community/nixvim
  programs.nixvim = {
    enable = true;

    # Use latest Neovim version available on nixos-unstable
    package = pkgs-unstable.neovim-unwrapped;

    # Set neovim as the default "basic/terminal" editor by setting the EDITOR environment variable
    defaultEditor = true;

    # Symlink `vi` and `vim` to `nvim` binary
    viAlias = true;
    vimAlias = true;
    # Alias `vimdiff` to `nvim -d`
    vimdiffAlias = true;

    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.xsel.enable = true;
    };

    # Install and configure Neovim plugins
    #
    # A lot of Neovim plugins are packaged in nixpkgs, see https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-plugin-names
    # Not all of those plugins are directly available in Nixvim.
    #
    # Depending on this availability, there are 3 ways to install a plugin:
    #
    # There are 2 ways to install plugins:
    # 1. A plugin is available in Nixvim
    #     - It's only matter of configuring it below in `plugins`. Refer to Nixvim's docs for the list of available plugins.
    # 2. A plugin is not available in Nixvim and it is packaged (or not) in nixpkgs
    #     - See `extraPlugins` below
    plugins = {
      #---------- Efficiency Plugins
      # Comment stuff out
      # https://github.com/tpope/vim-commentary
      commentary.enable = true;

      # Try to automatically adjust 'shiftwidth' and 'expandtab' based on the current file or its parents
      # https://github.com/tpope/vim-sleuth/
      sleuth.enable = true;
    };

    # List of plugins which are not directly available in Nixvim
    # See for the available plugins and their names: https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/vim-plugin-names
    #
    # If a plugin is packaged in nixpkgs, do this:
    # 1. Register the plugin below in `extraPlugins` with its name. So `pkgs.vimPlugins.some_plugin123` can be added as `some_plugin123`
    # 2. Configure the plugin through `extraConfigLua`, like `extraConfigLua = "require('some_plugin123').setup({foo = "bar"})";`
    #
    # Note: Any dot in the plugin name is replaced by a dash, so an an example `fzf.vim` becomes `fzf-vim`
    #
    # If a plugin isn't packaged in nixpkgs, do this:
    # 1. Build and register the plugin below in `extraPlugins` with `(pkgs.vimUtils.buildVimPlugin { (...) })`
    # 2. Configure the plugin through `extraConfigLua`, like `extraConfigLua = "require('some_plugin123').setup({foo = "bar"})";`
    extraPlugins = with pkgs.vimPlugins; [
      #---------- Efficiency Plugins
      # Lightning fast left-right movement
      # https://github.com/unblevable/quick-scope
      quick-scope

      # Indicate added/modified/removed lines for current file (if it's managed by a version control system)
      # https://github.com/mhinz/vim-signify
      vim-signify

      # Auto-pair brackets, parentheses, HTML tags, quotes, etc...
      # Automatically close certain structures like `if`, `do`, `def` in Ruby (and other languages)
      # https://github.com/cohama/lexima.vim
      lexima-vim

      #---------- Language Plugins
      # A collection of language plugins (150+ languages), useful for languages not supported by treesitter yet
      # https://github.com/sheerun/vim-polyglot
      vim-polyglot
    ];

    extraConfigLua = ''
      --- TODO: See what https://github.com/nvim-lua/kickstart.nvim does, maybe I can incorporate a few things...

      -------------------- Mappings
      ---- Mappings with vim.keymap.set are non-recursive by default
      -- Mouse can be used in all modes
      vim.opt.mouse = 'a'

      -- Set leader key to define extra key combinations with this. For example, to save the current file, define: map <leader>w
      -- It's recommended to set the leader key before plugins are loaded, otherwise the default (thus wrong) leader key will be used
      vim.g.mapleader = ','
      vim.g.maplocalleader = ','

      -- Allow Backspace, Space, left arrow, right arrow, h and l keys to move to the previous/next line when the cursor is on the first/last character in the line
      vim.opt.whichwrap = 'b,s,<,>,h,l'

      ---------- Insert Mode
      -- Non-recursive mapping for Shift+Tab to unindent
      vim.keymap.set('i', '<S-Tab>', '<C-D>')

      ---------- Normal Mode
      -- Non-recursive mappings for Ctrl + J and Ctrl + K to move the current line(s) up / down
      vim.keymap.set('n', '<C-j>', ':m .+1<CR>==')
      vim.keymap.set('n', '<C-k>', ':m .-2<CR>==')

      ---------- Visual and Select Modes
      -- Non-recursive mappings for Ctrl + J and Ctrl + K to move selected line(s) up / down
      vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
      vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")

      ---------- Normal, Visual and Operator Pending Modes
      -- Non-recursive mappings for n to always search forward and N to always search backward (for / and ?)
      --https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      vim.keymap.set({'n', 'v', 'o'}, 'n', "'Nn'[v:searchforward]", { expr = true })
      vim.keymap.set({'n', 'v', 'o'}, 'N', "'nN'[v:searchforward]", { expr = true })

      -- Non-recursive mappings to move around long wrapped lines
      vim.keymap.set({'n', 'v', 'o'}, 'j', 'gj')
      vim.keymap.set({'n', 'v', 'o'}, 'k', 'gk')

      -- Non-recursive mapping for leader + Enter to disable text highlighting
      vim.keymap.set({'n', 'v', 'o'}, '<leader><CR>', ':noh<CR>', { silent = true })

      -------------------- Command Mode
      -- Non-recursive abbreviations for common typos when saving/quiting
      vim.cmd.cnoreabbrev('W!', 'w!')
      vim.cmd.cnoreabbrev('W', 'w')
      vim.cmd.cnoreabbrev('Q!', 'q!')
      vim.cmd.cnoreabbrev('Q', 'q')
      vim.cmd.cnoreabbrev('Wq', 'wq')
      vim.cmd.cnoreabbrev('wQ', 'wq')
      vim.cmd.cnoreabbrev('WQ', 'wq')

      -------------------- UI Settings
      -- Enable true colors
      vim.opt.termguicolors = true

      -- Set the title of the terminal to the file's complete path (up to maximum 70 characters)
      vim.opt.title = true
      vim.opt.titlestring = 'neovim: %F' -- TODO: This isn't really useful to have the file's complete path, since it's quite long most of the time. The file name isn't visible then...
      vim.opt.titlelen = 70

      -- Format the status line
      vim.opt.statusline = 'FILE: %F%m%r%h %w  CWD: %r%{getcwd()}%h  Line: %l  Column: %c'

      -- Highlight the column and line where the cursor is currently
      vim.opt.cursorcolumn = true
      vim.opt.cursorline = true

      -- Always display the sign column (signs appear when lines are added/modified/deleted, some plugins like also LSP use signs)
      -- Without this setting, it's pretty annoying to always have the text shift to the right whenever the first sign appears
      vim.opt.signcolumn = 'yes'

      -- Show the line number where the cursor is located
      vim.opt.number = true

      -- Height (in number of lines) of the command bar at the bottom
      vim.opt.cmdheight = 2

      -- Show matching brackets when text indicator is over them
      vim.opt.showmatch = true

      -- How many tenths of a second to blink when matching brackets
      vim.opt.matchtime = 2

      -- Minimal number of screen lines to keep above and below the cursor when moving vertically (if possible...)
      vim.opt.scrolloff = 10

      -- Display tabs as │· (longer pipe) and trailing spaces as ·
      vim.opt.list = true
      vim.opt.listchars = 'tab:│·,trail:·'

      -- Disable word wrapping
      vim.opt.wrap = false

      -- Visually line break on lines of 500 characters (without actually inserting line break)
      vim.opt.linebreak = true
      vim.opt.textwidth = 500

      -------------------- Search Settings
      -- Use case-insensitive search by default
      vim.opt.ignorecase = true
      -- Use case-sensitive search if any of the search characters are uppercase
      vim.opt.smartcase = true

      ---------------------- History, Backup & System
      -- Use Unix as the standard file format
      vim.opt.fileformats = 'unix,dos,mac'

      -- Do not create backup files, my files are tracked in Git anyway
      vim.opt.backup = false
      vim.opt.writebackup = false

      -- Disable swap file
      vim.opt.swapfile = false

      -------------------- Wildmenu
      -- Ignore case
      vim.opt.wildignorecase = true

      -- Ignore these files
      vim.opt.wildignore = '*~,.git*,.hg*,.svn*'

      -- List all matches without completing
      vim.opt.wildmode = 'longest,list,full'
    '';
  };
}
