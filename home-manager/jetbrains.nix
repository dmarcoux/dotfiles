# User configuration for JetBrains IDEs

{ pkgs-unstable, ... }:

{
  # Install JetBrains IDEs with the JetBrains Toolbox
  home.packages = [ pkgs-unstable.jetbrains-toolbox ];

  # When migrating from one JetBrains account to another (like when getting a new job),
  # see my JetBrains settings backup at https://github.com/dmarcoux/jetbrains-settings

  # Configure IdeaVim, a plugin emulating Vim inside JetBrains IDEs
  # https://github.com/JetBrains/ideavim
  #
  # List of Supported Set Commands: https://github.com/JetBrains/ideavim/blob/master/doc/set-commands.md
  #
  # See list of actions and search for a specific action with `:actionlist <something>`
  #
  # Reload IdeaVim settings with `:source ~/.config/ideavim/ideavimrc`
  xdg.configFile."ideavim/ideavimrc".text = ''
    "---------- Mappings
    let mapleader=","

    "----- Handlers, configure which mappings are to be used by IdeaVim or the IDE in case of conflicts
    "      https://github.com/JetBrains/ideavim/wiki/sethandler
    "
    "      n - normal mode
    "      i - insert mode
    "      x - visual mode
    "      v - visual and select modes
    "      a - all modes

    " Ctrl + j is mapped below
    sethandler <C-j> a:vim
    " Ctrl + k is mapped below
    sethandler <C-k> a:vim
    " Ctrl + l is mapped below
    sethandler <C-l> a:vim
    " Ctrl + o is the opposite of the `gd` mapping in Normal mode. `gd` goes to the declaration of what's under the cursor, Ctrl + o goes back to where I came from
    sethandler <C-o> a:vim

    " Ctrl + p to open files via a fuzzy search
    sethandler <C-p> a:ide
    " Ctrl + n displays the recent files
    sethandler <C-n> a:ide
    " Ctrl + q displays the quick documentation
    sethandler <C-q> a:ide

    "----- Insert Mode
    " Non-recursive mappings to select and enter choice in an IDE list/lookup, like when autocompletion triggers"
    inoremap <C-k> :action EditorUp<CR>
    inoremap <C-l> :action EditorChooseLookupItem<CR>
    inoremap <C-j> :action EditorDown<CR>

    "----- Normal Mode
    " Non-recursive mappings for Ctrl + J and Ctrl + K to move the current line up / down and align it afterwards
    nnoremap <C-j> :action MoveLineDown<CR>==
    nnoremap <C-k> :action MoveLineUp<CR>==

    "------ Visual and Select Modes
    " TODO: This doesn't always keep the selection after moving, it's behaving in a weird way
    " Non-recursive mappings for Ctrl + J and Ctrl + K to move selected line(s) up / down
    "vnoremap <C-j> :m '>+1<CR>gv=gv
    "vnoremap <C-k> :m '<-2<CR>gv=gv

    "------ Normal, Visual and Operator Pending Modes
    " Non-recursive mapping for leader + Enter to disable text highlighting
    noremap <silent> <leader><CR> :noh<CR>

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
