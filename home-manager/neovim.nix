# User configuration for neovim

{ pkgs, pkgs-unstable, ... }:

{
  programs.neovim = {
    # Install Neovim
    enable = true;
    # Use latest Neovim version available on nixos-unstable
    package = pkgs-unstable.neovim-unwrapped;

    # Set neovim as the default "basic/terminal" editor by setting the EDITOR environment variable
    defaultEditor = true;

    extraConfig = ''
      lua << EOF
        -------------------- Plugins Settings
        ---------- nvim-cmp
        -- Display completion menu when there is one (menuone) or multiple (menu) suggestions and do not select a suggestion in the menu (noselect)
        vim.opt.completeopt = { "menu", "menuone", "noselect" }

        local cmp = require "cmp"

        cmp.setup({
          snippet = {
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body)
            end,
          },
          -- Do not preselect a suggestion in the completion menu when it opens
          preselect = cmp.PreselectMode.None,
          mapping = {
            -- Select next suggestion with Ctrl + j
            ["<C-j>"] = cmp.mapping.select_next_item(),
            -- Select previous suggestion with Ctrl + k
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            -- Trigger completion with Ctrl + Space
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            -- Exit completion
            ["<C-e>"] = cmp.mapping({
              i = cmp.mapping.abort(),
              c = cmp.mapping.close(),
            }),
             -- Accept currently selected suggestion with Ctrl + l. With `select` to `false`, only accept explicitly selected items.
            ["<C-l>"] = cmp.mapping.confirm({ select = false }),
          },
          -- Completion suggestions appear based on the order below
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
          }, {
            { name = 'buffer' },
          })
        })

        -- Setup lspconfig
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- Setup elixir_ls - https://github.com/elixir-lsp/elixir-ls
        require("lspconfig")["elixirls"].setup({
          cmd = { "${pkgs-unstable.elixir_ls}/lib/language_server.sh" },
          capabilities = capabilities,
          settings = {
            elixirLS = {
              -- Disable Dialyzer until I'm more familiar with it...
              dialyzerEnabled = false,
            }
          }
        })
        -- Setup gopls - https://github.com/golang/tools/tree/master/gopls
        require("lspconfig")["gopls"].setup({
          cmd = { "${pkgs-unstable.gopls}/bin/gopls" },
          capabilities = capabilities
        })
      EOF

      "-------------------- Mappings
      " Mouse can be used in all modes
      set mouse=a

      " Define extra key combinations with a map leader. For example, to save the current file, define: map <leader>w
      let mapleader=","

      " Left and right movements will go to the previous or next line when at start or end of line
      " https://vim.fandom.com/wiki/Automatically_wrap_left_and_right
      set whichwrap+=<,>,h,l

      "---------- Insert Mode
      " Non-recursive mapping for Shift+Tab to unindent
      inoremap <S-Tab> <C-D>

      "---------- Normal Mode
      " Non-recursive mappings for Ctrl + J and Ctrl + K to move the current line(s) up / down
      nnoremap <C-j> :m .+1<CR>==
      nnoremap <C-k> :m .-2<CR>==

      "---------- Visual and Select Modes
      " Non-recursive mappings for Ctrl + J and Ctrl + K to move selected line(s) up / down
      vnoremap <C-j> :m '>+1<CR>gv=gv
      vnoremap <C-k> :m '<-2<CR>gv=gv

      "---------- Normal, Visual and Operator Pending Modes
      " Non-recursive mappings for n to always search forward and N to always search backward (for / and ?)
      noremap <expr> n  'Nn'[v:searchforward]
      noremap <expr> N  'nN'[v:searchforward]

      " Non-recursive mappings to move around long wrapped lines
      noremap j gj
      noremap k gk

      " Non-recursive mapping for leader + Enter to disable text highlighting
      noremap <silent> <leader><CR> :noh<CR>

      "-------------------- Command Mode
      " Non-recursive abbreviations for common typos when saving/quiting
      cnoreabbrev W! w!
      cnoreabbrev W w
      cnoreabbrev Q! q!
      cnoreabbrev Q q
      cnoreabbrev Wq wq
      cnoreabbrev wQ wq
      cnoreabbrev WQ wq

      " When forgetting to sudo before editing a file which requires root privileges, use w!! instead of w! to save changes
      cmap w!! w !sudo tee % >/dev/null

      "-------------------- UI Settings
      " Enable true colors
      set termguicolors

      " Set the title of the terminal to the file name (up to maximum 70 characters)
      set title
      set titlestring=neovim:\ %F titlelen=70

      " Format the status line
      set statusline=\ FILE:\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

      " Highlight the column and line where the cursor is currently
      set cursorcolumn
      set cursorline

      " Always display the sign column (signs appear when lines are added/modified/deleted, some plugins like also LSP use signs)
      " Without this setting, it's pretty annoying to always have the text shift to the right whenever the first sign appears
      set signcolumn=yes

      " Show the line number where the cursor is located
      set number

      " Height (in number of lines) of the command bar at the bottom
      set cmdheight=2

      " Show matching brackets when text indicator is over them
      set showmatch

      " How many tenths of a second to blink when matching brackets
      set mat=2

      " Minimal number of screen lines to keep above and below the cursor when moving vertically (if possible...)
      set scrolloff=10

      " Display tabs as │· (longer pipe) and trailing spaces as ·
      set list listchars=tab:\│·,trail:·

      " Disable word wrapping
      set nowrap

      " Visually line break on lines of 500 characters (without actually inserting line break)
      set linebreak
      set tw=500

      " Don't redraw while executing macros, registers and other commands
      set lazyredraw

      "-------------------- Search Settings
      " Use case-insensitive search by default
      set ignorecase
      " Use case-sensitive search if any of the search characters are uppercase
      set smartcase

      "-------------------- History, Backup & System
      " Link to the system clipboard
      set clipboard^=unnamedplus

      " Use Unix as the standard file format
      set fileformats=unix,dos,mac

      " Disable backup
      set nobackup
      set nowritebackup

      " Disable swap file
      set noswapfile

      "-------------------- Wildmenu
      " Ignore case
      set wildignorecase

      " Ignore these files
      set wildignore+=*~,.git\*,.hg\*,.svn\*

      " List all matches without completing
      set wildmode=longest,list,full

      "-------------------- Autocommands
      autocmd BufNewFile,BufReadPost *.md call SetMarkdownOptions()
      function SetMarkdownOptions()
          " Force Markdown type for all files with the .md extension (from tpope/vim-markdown)
          set filetype=markdown
          " Wrap lines at 80 characters
          setlocal textwidth=80
      endfunction

      " Move the quickfix window at the very bottom, no matter what
      " See ':help :wincmd' and ':help ^WJ' for more info
      autocmd FileType qf wincmd J

      "-------------------- Plugins Settings
      "---------- fzf-vim
      " Non-recursive mapping in Normal and Visual modes for Ctrl+p to start fzf for files
      nnoremap <C-p> :Files<CR>
      vnoremap <C-p> :Files<CR>
      " Non-recursive mapping in Normal and Visual modes for Ctrl+n to start fzf for buffers
      nnoremap <C-n> :Buffers<CR>
      vnoremap <C-n> :Buffers<CR>
      " Display the fzf window at the bottom of the screen with 40% of the available height
      let g:fzf_layout = { 'down': '40%' }

      "---------- nvim-solarized-lua
      " Use light version of colorscheme
      set background=light

      " Set colorscheme if it's installed (otherwise it fails silently)
      silent! colorscheme solarized

      "---------- tagbar
      " Open tagbar automatically for supported filetypes whenever opening a file
      autocmd FileType * nested :call tagbar#autoopen(0)

      "---------- wstrip-vim
      " Enable wstrip-vim on all filetypes to remove trailing whitespaces only on changed lines
      " It's useful in rare occasions to disable this in a buffer, do it with the Neovim command `:let b:wstrip_auto = 0`
      let g:wstrip_auto = 1

      "---------- vim-rooter
      " A root directory will have a `.git` directory
      let g:rooter_patterns = ['.git']
    '';

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

  # Minimal Neovim configuration for Git, like when doing `git commit --amend`
  # It duplicates some parts of the config above, but only what's needed.
  # TODO: Find a way to load this config into the main config.
  xdg.configFile."nvim/git.vim".text = ''
      "-------------------- Mappings
      " Mouse can be used in all modes
      set mouse=a

      " Left and right movements will go to the previous or next line when at start or end of line
      " https://vim.fandom.com/wiki/Automatically_wrap_left_and_right
      set whichwrap+=<,>,h,l

      "---------- Insert Mode
      " Non-recursive mapping for Shift+Tab to unindent
      inoremap <S-Tab> <C-D>

      "---------- Normal Mode
      " Non-recursive mappings for Ctrl + J and Ctrl + K to move the current line(s) up / down
      nnoremap <C-j> :m .+1<CR>==
      nnoremap <C-k> :m .-2<CR>==

      "---------- Visual and Select Modes
      " Non-recursive mappings for Ctrl + J and Ctrl + K to move selected line(s) up / down
      vnoremap <C-j> :m '>+1<CR>gv=gv
      vnoremap <C-k> :m '<-2<CR>gv=gv

      "-------------------- History, Backup & System
      " Link to the system clipboard
      set clipboard^=unnamedplus

      "-------------------- Command Mode
      " Non-recursive abbreviations for common typos when saving/quiting
      cnoreabbrev W! w!
      cnoreabbrev W w
      cnoreabbrev Q! q!
      cnoreabbrev Q q
      cnoreabbrev Wq wq
      cnoreabbrev wQ wq
      cnoreabbrev WQ wq
  '';
}
