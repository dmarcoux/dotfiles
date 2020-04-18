HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# Share history among all shells
setopt SHARE_HISTORY

# If a new command line being added to the history list duplicates an older one,
# the older command is removed from the list (even if it is not the previous event)
setopt HIST_IGNORE_ALL_DUPS

# Remove superfluous blanks from each command line being added to the history
setopt HIST_REDUCE_BLANKS
