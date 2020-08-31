# User configuration for neovim

{ pkgs, unstable, ... }:

{
  xdg.configFile."nvim/coc-settings.json".text = ''
    {
      "rust-analyzer.serverPath": "${unstable.rust-analyzer}/bin/rust-analyzer"
    }
  '';

  programs.neovim = {
    enable = true;

    extraConfig = ''
      "-------------------- Mappings
      " Mouse can be used in all modes
      set mouse=a

      " Mappings are recursive, so they will keep evaluating until they hit a dead end (a non-recursive mapping or the last mapping)
      set remap

      " Define extra key combinations with a map leader. For example, to save the current file, define: map <leader>w
      let mapleader=","

      " Left and right movements will go to the previous or next line when at start or end of line
      set whichwrap+=<,>,h,l

      "---------- Insert Mode
      " Non-recursive mapping for Shift+Tab to unindent
      inoremap <S-Tab> <C-D>

      "---------- Normal Mode
      " Non-recursive mappings for Ctrl + J and Ctrl + K to move the current line(s)
      nnoremap <C-j> :m .+1<CR>==
      nnoremap <C-k> :m .-2<CR>==

      "---------- Visual and Select Modes
      " Non-recursive mappings for Ctrl + J and Ctrl + K to move selected line(s)
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

      " Display tabs and trailing spaces as ·
      set list listchars=tab:\>·,trail:·

      " Disable word wrapping
      set nowrap

      " Visually line break on lines of 500 characters (without actually inserting line break)
      set linebreak
      set tw=500

      " Don't redraw while executing macros, registers and other commands
      set lazyredraw

      "-------------------- Search Settings
      " Ignore case when searching
      set ignorecase

      "-------------------- Space, Tabs & Indentation
      " An indent is automatically inserted:
      "- After a line ending in '{'.
      "- After a line starting with a keyword from this list: if, else, while, do, for, switch
      "- Before a line starting with '}' (only with the 'O' command).
      set smartindent

      "-------------------- History, Backup & System
      " Hide buffers, instead of closing them.
      " Having unwritten changes in a file and opening a new file using :e, won't force saving or undoing changes first.
      " Undo buffers and marks are preserved while the buffer is open
      set hidden

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
      " Remove all trailing whitespaces right before saving
      autocmd BufWritePre * :%s/\s\+$//e

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
      "---------- NeoSolarized
      " Use light version of colorscheme
      set background=light

      " Set NeoSolarized colorscheme if it's installed (otherwise it fails silently)
      silent! colorscheme NeoSolarized

      "---------- tagbar
      " Open tagbar automatically for supported filetypes whenever opening a file
      autocmd FileType * nested :call tagbar#autoopen(0)

      "----------  vim-closetag
      " Enable vim-closetag for files with the following extensions and types
      let g:closetag_filenames = '*.html,*.vue'
      let g:closetag_filetypes = 'html,vue'

      "---------- coc-nvim
      " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
      set updatetime=300

      " Don't pass messages to |ins-completion-menu|.
      set shortmess+=c

      " Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
      set signcolumn=yes

      " Use tab for trigger completion with characters ahead and navigate.
      " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
      " other plugin before putting this into your config.
      inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
      inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

      function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      " Use Ctrl+Space to trigger completion.
      inoremap <silent><expr> <c-space> coc#refresh()

      " If the completion menu is visible, Ctrl + j is mapped to Ctrl + n (default binding) to go to the next entry
      " If the completion menu isn't visible, <Ctrl + j stays the same
      inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
      " If the completion menu is visible, Ctrl + k is mapped to Ctrl + p (default binding) to go to the previous entry
      " If the completion menu isn't visible, <Ctrl + k stays the same
      inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

      " Use Ctrl + l to confirm completion, `<C-g>u` means break undo chain at current
      " position. Coc only does snippet and additional edit on confirm.
      " Enter could be remapped by other vim plugin, try `:verbose imap <C-l>`.
      if exists('*complete_info')
        inoremap <expr> <C-l> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
      else
        inoremap <expr> <C-l> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
      endif

      " Use `[g` and `]g` to navigate diagnostics
      " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
      nmap <silent> [g <Plug>(coc-diagnostic-prev)
      nmap <silent> ]g <Plug>(coc-diagnostic-next)

      " GoTo code navigation.
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " Use K to show documentation in preview window.
      nnoremap <silent> K :call <SID>show_documentation()<CR>

      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction

      " Highlight the symbol and its references when holding the cursor.
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Symbol renaming.
      nmap <leader>rn <Plug>(coc-rename)

      " Formatting selected code.
      xmap <leader>f  <Plug>(coc-format-selected)
      nmap <leader>f  <Plug>(coc-format-selected)

      augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      augroup end

      " Applying codeAction to the selected region.
      " Example: `<leader>aap` for current paragraph
      xmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>a  <Plug>(coc-codeaction-selected)

      " Remap keys for applying codeAction to the current buffer.
      nmap <leader>ac  <Plug>(coc-codeaction)
      " Apply AutoFix to problem on the current line.
      nmap <leader>qf  <Plug>(coc-fix-current)

      " Map function and class text objects
      " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
      xmap if <Plug>(coc-funcobj-i)
      omap if <Plug>(coc-funcobj-i)
      xmap af <Plug>(coc-funcobj-a)
      omap af <Plug>(coc-funcobj-a)
      xmap ic <Plug>(coc-classobj-i)
      omap ic <Plug>(coc-classobj-i)
      xmap ac <Plug>(coc-classobj-a)
      omap ac <Plug>(coc-classobj-a)

      " Use CTRL-S for selections ranges.
      " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
      nmap <silent> <C-s> <Plug>(coc-range-select)
      xmap <silent> <C-s> <Plug>(coc-range-select)

      " Add `:Format` command to format current buffer.
      command! -nargs=0 Format :call CocAction('format')

      " Add `:Fold` command to fold current buffer.
      command! -nargs=? Fold :call     CocAction('fold', <f-args>)

      " Add `:OR` command for organize imports of the current buffer.
      command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

      " Add (Neo)Vim's native statusline support.
      " NOTE: Please see `:h coc-status` for integrations with external plugins that
      " provide custom statusline: lightline.vim, vim-airline.
      set statusline^=%{coc#status()}%{get(b:,'coc_current_function',''')}

      " Mappings for CoCList
      " Show all diagnostics.
      nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
      " Manage extensions.
      nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
      " Show commands.
      nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
      " Find symbol of current document.
      nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
      " Search workspace symbols.
      nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
      " Do default action for next item.
      nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
      " Do default action for previous item.
      nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
      " Resume latest coc list.
      nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

      " TODO: Replace this by rust-analyzer.inlayHints.enable false in .config/nvim/coc-settings.json
      "       See issue https://github.com/fannheyward/coc-rust-analyzer/issues/346
      " autocmd BufNewFile,BufRead,FileReadPost *.rs :CocCommand rust-analyzer.toggleInlayHints
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

      # Autocompletion
      unstable.vimPlugins.coc-nvim
      unstable.vimPlugins.coc-rust-analyzer

      # Highlight copied/yanked region
      vim-highlightedyank

      # Indicate added/modified/removed lines for current file (if it's managed by a version control system)
      vim-signify

      # Auto close HTML tags
      vim-closetag

      # Insert/Delete brackets, parentheses and quotes in pair
      auto-pairs

      # Automatically close certain structures like `if`, `do`, `def` in Ruby (and other languages)
      vim-endwise

      #---------- Colorscheme Plugins
      # Solarized light and dark colorscheme
      NeoSolarized

      #---------- Language Plugins
      # A collection of language plugins (150+ languages)
      vim-polyglot
    ];

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
