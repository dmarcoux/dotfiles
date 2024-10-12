{
  programs.bash.initExtra = ''
    # Allow completion from within a word/phrase
    bind 'set show-all-if-ambiguous on'

    # When completing from the middle of a word, move the cursor to the end of the word
    bind 'TAB:menu-complete'

    # Match files beginning with a dot without explicitly specifying the dot
    shopt -s dotglob

    # Case insensitive
    bind 'set completion-ignore-case on'
  '';
}
