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

---------- Normal, Visual and Operator Pending Modes
-- Non-recursive mappings for n to always search forward and N to always search backward (for / and ?)
--https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({'n', 'v', 'o'}, 'n', "'Nn'[v:searchforward]", { noremap = true, expr = true })
vim.keymap.set({'n', 'v', 'o'}, 'N', "'nN'[v:searchforward]", { noremap = true, expr = true })

-- Non-recursive mappings to move around long wrapped lines
vim.keymap.set({'n', 'v', 'o'}, 'j', 'gj', { noremap = true })
vim.keymap.set({'n', 'v', 'o'}, 'k', 'gk', { noremap = true })

-- Non-recursive mapping for leader + Enter to disable text highlighting
vim.keymap.set({'n', 'v', 'o'}, '<leader><CR>', ':noh<CR>', { noremap = true, silent = true })

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
-- Link to the system clipboard. Enable the setting after `UiEnter` to reduce startup time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

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

vim.cmd [[
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
