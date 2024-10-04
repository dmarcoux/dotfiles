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
  cmd = { "/nix/store/jd36kvjf6da76q01lr0g6s7hnl4q8qg7-elixir-ls-0.23.0/lib/language_server.sh" },
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
  cmd = { "/nix/store/6nysag23irns7ldbsdrjwc1ckap1hqm6-gopls-0.16.2/bin/gopls" },
  capabilities = capabilities
})

-------------------- Mappings
-- Mouse can be used in all modes
vim.opt.mouse = 'a'

-- Set leader key to define extra key combinations with this. For example, to save the current file, define: map <leader>w
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Allow Backspace, Space, left arrow, right arrow, h and l keys to move to the previous/next line when the cursor is on the first/last character in the line
vim.opt.whichwrap = 'b,s,<,>,h,l'

---------- Insert Mode
-- Non-recursive mapping for Shift+Tab to unindent
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-D>', { noremap = true })

---------- Normal Mode
-- Non-recursive mappings for Ctrl + J and Ctrl + K to move the current line(s) up / down
vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':m .-2<CR>==', { noremap = true })

---------- Visual and Select Modes
-- Non-recursive mappings for Ctrl + J and Ctrl + K to move selected line(s) up / down
vim.api.nvim_set_keymap('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true })

vim.cmd [[
"-------------------- Mappings
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
]]
