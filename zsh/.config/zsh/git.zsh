ealias g='git'
ealias ga='git add'
# List branches
ealias gbra='git branch'
# Delete merged branches after confirming (with y)
ealias gbramd='git branch --merged | grep --extended-regexp --invert-match "(^\*|master)" | cut --characters=3- | xargs --no-run-if-empty --interactive git branch --delete'
ealias gchp='git cherry-pick'
ealias gcko='git checkout'
# Create a new branch from current branch
ealias gckob='git checkout -b'
# Select a branch with fzf and switch to it
alias gckof='git branch | fzf | cut --characters=3- | xargs --no-run-if-empty git checkout'
ealias gclo='git clone'
# Create a git commit (it will use any git commit message template set in config)
ealias gco='git commit'
# Create a git commit with message (it skips any git commit message template set in config)
ealias gcom='git commit --message'
# Create a git commit with a message and open the editor (it skips any git commit message template set in config)
ealias gcoem='git commit --edit --message'
ealias gcoma='git commit --amend'
ealias gdi='git diff'
ealias gdis='git diff --staged'
ealias gf='git fetch --tags'
ealias gfu='git fetch --tags upstream'
# Output: abbreviated_commit_hash (%h) | commit_message (%s) | author_name (%an, in yellow) | commit_date_relative (%cr, in green)
ealias glo='git log --pretty=format:"%h %C(bold)|%C(reset) %s %C(bold)|%C(reset) %C(yellow)%an%C(reset) %C(bold)|%C(reset) %C(green)%cr%C(reset)" --max-count=100'
# Copy a string from the output of the glo alias (a commit hash for example)
alias gloy='glo | yank'
ealias gmer='git merge'
# Select a branch with fzf and merge it in the current branch
alias gmerf='git branch | fzf | cut --characters=3- | xargs --no-run-if-empty git merge'
ealias gpu='git push'
# Force push changes, but only if it won't overwrite changes from someone else on remote
ealias gpuf='git push --force-with-lease'
ealias gpure='git pull --rebase --autostash'
ealias greb='git rebase'
ealias grebc='git rebase --continue'
# From the output of the glo alias, select with fzf the commit hash to rebase on
alias grebi='glo | fzf --ansi --no-sort | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty -I % bash -c "</dev/tty git rebase --interactive %"'
ealias gref='git reflog' # then: git reset HEAD@{index}
ealias gres='git reset'
ealias grev='git revert'
# Select a commit with fzf and revert it
alias grevf='glo | fzf --ansi --no-sort | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git revert'
ealias gsh='git show'
# Select a commit with fzf and show it
alias gshf='glo | fzf --ansi --no-sort --preview "echo {} | cut --delimiter=\" \" --fields=1 | xargs git show" | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git show'
ealias gst='git status'
ealias gsta='git stash'
# Select a stash with fzf and show it
ealias gstaf='git stash list | fzf --no-sort | sed -n "s/^stash@{\(.*\)}.*/\1/p" | xargs --no-run-if-empty git stash show'
ealias gstal='git stash list'
ealias gsu='git submodule update'

GITHUB_USER="dmarcoux"

# Add a Git repository (source) with its complete history to another one (destination). It doesn't overwrite the destination, the source's history is simply added
# - "source" and "destination" have to be the URL to a repo. Example: git@github.com:dmarcoux/dotfiles.git
add_repo() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    # Display usage
    echo "Usage: ${funcstack[1]} git@github.com:example/source_repo.git git@github.com:example/destination_repo.git"
    return
  fi

  SOURCE="$1"
  DESTINATION="$2"

  # Setup temporary directories
  mkdir ~/tmp
  rm --recursive --force ~/tmp/source ~/tmp/destination

  # Clone source and destination Git repositories
  git clone $SOURCE ~/tmp/source
  git clone $DESTINATION ~/tmp/destination

  # Add source remote in destination
  cd ~/tmp/destination
  git remote add source $SOURCE

  # Pull source's master in destination's master
  git pull source master --allow-unrelated-histories

  # Remove source remote from destination
  git remote rm source

  echo 'Manual steps to be sure everything is fine'
  echo 'git log'
  echo 'git push'
}

# Setup a Git repository for an existing fork. It clones the repository, sets the remotes and HEADs for upstream and the fork.
setup_existing_fork() {
  if [ -z "$1" ]; then
    # Display usage
    echo "Usage: ${funcstack[1]} git@github.com:username/upsteam_repo.git"
    return
  fi

  UPSTREAM="$1"
  # replace whatever is between : and / in $UPSTREAM by $GITHUB_USER
  FORK="$(sed "s|:.*/|:$GITHUB_USER/|g" <<<"$UPSTREAM")"
  REPOSITORY_NAME="$(basename "$1" .git)"

  # Clone repository
  git clone "$UPSTREAM"

  # Go into cloned repository and set the remotes and HEADs
  (
    cd "$REPOSITORY_NAME" || exit

    git remote add upstream "$UPSTREAM"
    git fetch --tags upstream
    git remote set-head upstream master

    git remote set-url origin "$FORK"
    git fetch --tags origin
    git remote set-head origin master
  )
}

# Update fork of a Git repository (it has to be setup with fork_repo to follow the remote naming convention)
update_fork() {
  # Get the default branch (it's not always 'master'... there are other cases like 'gh-pages' for GitHub pages for example)
  DEFAULT_BRANCH="$(git symbolic-ref refs/remotes/upstream/HEAD | sed 's\^refs/remotes/upstream/\\')"

  # Checkout the default branch
  git checkout "$DEFAULT_BRANCH"

  # Rebase the default branch on the upstream changes
  git pull --rebase --autostash upstream "$DEFAULT_BRANCH"

  # Push updated default branch to my fork
  git push origin "$DEFAULT_BRANCH"

  git submodule update
}

# Checkout branch of someone else's fork
checkout_fork() {
  if [ -z "$1" ]; then
    # Display usage
    echo "Usage: ${funcstack[1]} username:branch"
    return
  fi

  USER="$(echo "$1" | cut --delimiter=':' --fields=1)"
  BRANCH="$(echo "$1" | cut --delimiter=':' --fields=2)"
  REMOTE="$(git config remote.origin.url | sed -e "s|:.*/|:$USER/|g")"

  # Add a remote for the fork (if one with the same name doesn't already exist)
  if ! git remote get-url "$USER" > /dev/null 2>&1; then
    git remote add "$USER" "$REMOTE"
  fi

  # Fetch branches of the fork
  git fetch --tags "$USER"

  # Checkout the fork's branch
  git checkout "$USER"/"$BRANCH"

  # Create a local copy of the fork's branch
  git checkout -b "$BRANCH"
}
