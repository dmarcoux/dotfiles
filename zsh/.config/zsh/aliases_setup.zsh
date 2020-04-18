# Setup aliases to be defined as expandable (or not) and expands the expandable ones whenever Space is pressed
#
# Usage
# - Define expandable aliases with ealias
# - Define non-expandable aliases with alias (as usual)
#
# Shamelessly taken from https://wiki.math.cmu.edu/iki/wiki/tips/20140625-zsh-expand-alias.html

# Define an array to store expandable aliases
typeset -a ealiases
ealiases=()

# Add an expandable alias
function ealias() {
  alias $1
  ealiases+=(${1%%\=*})
}

# Expand expandable aliases whenever Space is pressed (as defined below in the bindkey statements)
function expand-ealias() {
  if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)ealiases})\$" ]]; then
    # An expandable alias was found, it will be expanded
    zle _expand_alias
    zle expand-word
  fi

  # Without this, Space isn't never added when this function fires
  zle self-insert
}

zle -N expand-ealias

# Space expands all expandable aliases
bindkey -M emacs " " expand-ealias
bindkey -M viins " " expand-ealias

# Control-Space avoids expanding expandable aliases
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# Normal space during searches
bindkey -M isearch " " magic-space
