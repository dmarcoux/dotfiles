# If exa is installed, set it up
if type exa > /dev/null 2>&1; then
  ealias ls='exa --all --group-directories-first --across'
  ealias ll='exa --all --group-directories-first --long'
fi
