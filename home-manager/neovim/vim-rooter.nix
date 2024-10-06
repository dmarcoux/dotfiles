{ pkgs, ... }:

{
  programs.nixvim = {
    # Change Vim working directory to project root (defined by the presence of a .git directory or anything else, it's configurable)
    # https://github.com/airblade/vim-rooter
    extraPlugins = [ pkgs.vimPlugins.vim-rooter ];

    # A root directory will have a `.git` directory
    globals.rooter_patterns = [ ".git" ];
  };
}
