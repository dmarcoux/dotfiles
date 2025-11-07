{
  programs.zsh.initContent = ''
    # Allow completion from within a word/phrase
    setopt COMPLETE_IN_WORD

    # When completing from the middle of a word, move the cursor to the end of the word
    setopt ALWAYS_TO_END

    # Match files beginning with a dot without explicitly specifying the dot
    setopt GLOBDOTS

    # Enable usage of bash autocompletion functions
    autoload -U +X bashcompinit && bashcompinit

    # Case insensitive
    zstyle ":completion:*" matcher-list "m:{a-zA-Z}={A-Za-z}"

    zstyle ":completion:*" verbose yes

    zstyle ":completion:*" group-name ""

    zstyle ":completion:*" menu select=long

    zstyle ":completion:*" use-compctl false
  '';
}
