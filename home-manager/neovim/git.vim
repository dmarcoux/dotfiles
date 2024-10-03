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
