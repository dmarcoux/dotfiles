# User configuration for JetBrains IDEs

{ pkgs, ... }:

{
  # Install JetBrains Rider, a .NET IDE based on the IntelliJ platform and ReSharper
  home.packages = [ pkgs.unstable.jetbrains.rider ];

  # Configure IdeaVim, a plugin emulating Vim inside JetBrains IDEs
  # https://github.com/JetBrains/ideavim
  #
  # List of Supported Set Commands: https://github.com/JetBrains/ideavim/blob/master/doc/set-commands.md
  #
  # Reload IdeaVim settings with `:source ~/.config/ideavim/ideavimrc`
  xdg.configFile."ideavim/ideavimrc".text = ''
    "---------- Mappings
    " TODO: Use sethandler to configure which shortcuts are to be used by Vim in case of conflicts with IDE
    "       https://github.com/JetBrains/ideavim/wiki/sethandler
    "----- Insert Mode
    " Non-recursive mappings to select and enter choice in an IDE list/lookup, like when autocompletion triggers"
    inoremap <C-k> :action EditorUp<CR>
    inoremap <C-l> :action EditorChooseLookupItem<CR>
    inoremap <C-j> :action EditorDown<CR>

    "----- Normal Mode
    " Non-recursive mappings for Ctrl + J and Ctrl + K to move the current line(s) up / down
    nnoremap <C-j> :action MoveLineDown<CR>
    nnoremap <C-k> :action MoveLineUp<CR>

    "------ Visual and Select Modes
    " TODO: This doesn't always keep the selection after moving, it's behaving in a weird way
    " Non-recursive mappings for Ctrl + J and Ctrl + K to move selected line(s) up / down
    vnoremap <C-j> :m '>+1<CR>gv=gv
    vnoremap <C-k> :m '<-2<CR>gv=gv

    "---------- UI Settings
    " Minimal number of screen lines to keep above and below the cursor when moving vertically (if possible...)
    set scrolloff=10

    "---------- System Settings"
    " Link to system clipboard
    set clipboard^=unnamedplus

    "---------- Search Settings
    " Use case-insensitive search by default
    set ignorecase
    " Use case-sensitive search if any of the search characters are uppercase
    set smartcase
    " Start searching as I type
    set incsearch
    " Highlight all search matches
    set hlsearch

    "---------- IdeaVim Plugins - https://github.com/JetBrains/ideavim/wiki/IdeaVim-Plugins
    " Join lines with J - https://github.com/JetBrains/ideavim/blob/master/doc/ideajoin-examples.md
    set ideajoin
    " Highlight copied/yanked region
    set highlightedyank
    " Lightning fast left-right movement - https://plugins.jetbrains.com/plugin/19417-ideavim-quickscope
    set quickscope
    " Comment stuff out - https://github.com/tpope/vim-commentary
    set commentary
  '';
}
