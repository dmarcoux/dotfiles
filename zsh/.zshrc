# Do this first, then don't care about load order of config files loaded below, even if they set custom key bindings
bindkey -e # Use emacs key bindings

# Load the config files
for config (~/.config/zsh/**/*.zsh) source $config
