# If bat is installed, set it up
if type bat > /dev/null 2>&1; then
  # FIXME: Use solarized light theme (it's not available now and the available themes are not so nice)
  alias cat='bat --color=never'
fi
