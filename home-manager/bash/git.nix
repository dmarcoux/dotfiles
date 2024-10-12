{
  programs.bash.initExtra = ''
    alias g='git'
    alias ga='git add'
    # Useful to diff untracked files, see https://stackoverflow.com/questions/24329051/what-does-git-add-intent-to-add-or-n-do-and-when-should-it-be-used
    alias gaia='git add --intent-to-add'
    # List branches
    alias gbra='git branch'
    # Delete a branch
    alias gbrad='git branch -D'
    alias gchp='git cherry-pick'
    alias gcko='git checkout'
    # Create a new branch from current branch
    alias gckob='git checkout -b'
    # Select a branch with fzf and switch to it
    alias gckof='git branch | fzf | cut --characters=3- | xargs --no-run-if-empty git checkout'
    alias gclo='git clone'
    # Create a git commit (it will use any git commit message template set in config)
    alias gco='git commit'
    # Select a commit with fzf for which a commit fixup is going to be created with the current staged changes
    alias gcof='glo | fzf --ansi --no-sort | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git commit --fixup'
    # Create a git commit with message (it skips any git commit message template set in config)
    alias gcom='git commit --message'
    # Create a git commit with a message and open the editor (it skips any git commit message template set in config)
    alias gcoem='git commit --edit --message'
    alias gcoma='git commit --amend'
    alias gdi='git diff --relative' # show diffs relative to the current directory
    # Quickly edit changed files with `vim $(gdino)`
    alias gdino='git diff --name-only'
    alias gdis='git diff --staged'
    alias gf='git fetch --tags'
    alias gfu='git fetch --tags upstream'
    # Output: abbreviated_commit_hash (%h) | commit_message (%s) | author_name (%an, in yellow) | commit_date_relative (%cr, in green)
    alias glo='git log --pretty=format:"%h %C(bold)|%C(reset) %s %C(bold)|%C(reset) %C(yellow)%an%C(reset) %C(bold)|%C(reset) %C(green)%cr%C(reset)" --max-count=100'
    # Copy a string from the output of the glo alias (a commit hash for example)
    alias gloy='glo | yank'
    alias gmer='git merge'
    # Select a branch with fzf and merge it in the current branch
    alias gmerf='git branch | fzf | cut --characters=3- | xargs --no-run-if-empty git merge'
    alias gpu='git push'
    # Force push changes, but only if it won't overwrite changes from someone else on remote
    alias gpuf='git push --force-with-lease'
    alias gpure='git pull --rebase --autostash'
    alias greb='git rebase'
    alias grebc='git rebase --continue'
    # From the output of the glo alias, select with fzf the commit hash to rebase on
    alias grebi='glo | fzf --ansi --no-sort | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty -I % bash -c "</dev/tty git rebase --interactive %"'
    alias gref='git reflog' # then: git reset HEAD@{index}
    alias gres='git reset'
    alias grev='git revert'
    alias grst='git restore --staged'
    # Select commit(s) with fzf and revert it
    alias grevf='glo | fzf --ansi --no-sort --multi | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git revert'
    alias gsh='git show'
    # Select a commit with fzf and show it
    alias gshf='glo | fzf --ansi --no-sort --preview "echo {} | cut --delimiter=\" \" --fields=1 | xargs git show" | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty git show'
    alias gst='git status'
    alias gsta='git stash'
    # Select a stash with fzf and show it
    alias gstaf='git stash list | fzf --no-sort | sed -n "s/^stash@{\(.*\)}.*/\1/p" | xargs --no-run-if-empty git stash show'
    alias gstal='git stash list'
    alias gsu='git submodule update'

    # Add a Git repository (source) with its complete history to another one (destination). It doesn't overwrite the destination, the source's history is simply added
    # - "source" and "destination" have to be the URL to a repo. Example: git@github.com:dmarcoux/dotfiles.git
    add_repo() {
      if [ -z "$1" ] || [ -z "$2" ]; then
        # Display usage
        echo "Usage: ''${funcstack[1]} git@github.com:example/source_repo.git git@github.com:example/destination_repo.git"
        return
      fi

      SOURCE="$1"
      DESTINATION="$2"

      # Setup temporary directories
      mkdir ~/tmp
      rm --recursive --force ~/tmp/source ~/tmp/destination

      # Clone source Git repository
      git clone $SOURCE ~/tmp/source

      # Get the default branch (it's not always 'master'... there are other cases like 'gh-pages' for GitHub pages for example)
      cd ~/tmp/source
      SOURCE_DEFAULT_BRANCH="$(git remote show origin | sed -n 's| *HEAD branch: ||p')"

      # Clone destination Git repository
      git clone $DESTINATION ~/tmp/destination

      # Get the default branch (it's not always 'master'... there are other cases like 'gh-pages' for GitHub pages for example)
      cd ~/tmp/destination
      DESTINATION_DEFAULT_BRANCH="$(git remote show origin | sed -n 's| *HEAD branch: ||p')"

      # Add source remote in destination
      git remote add source $SOURCE

      # Pull source's default branch in destination's
      git checkout $DESTINATION_DEFAULT_BRANCH
      git pull source $SOURCE_DEFAULT_BRANCH --allow-unrelated-histories

      # Remove source remote from destination
      git remote rm source

      echo 'Manual steps to be sure everything is fine'
      echo 'git log'
      echo 'git push'
    }

    # Delete merged branches after confirming (with y)
    gbramd() {
      # Get the default branch (it's not always 'master'... there are other cases like 'gh-pages' for GitHub pages for example)
      DEFAULT_BRANCH="$(git remote show origin | sed -n 's| *HEAD branch: ||p')"

      git branch --merged | grep --extended-regexp --invert-match "(^\*|$DEFAULT_BRANCH)" | cut --characters=3- | xargs --no-run-if-empty --interactive git branch --delete
    }

    # Update fork of a Git repository (it has to be setup with fork_repo to follow the remote naming convention)
    update_fork() {
      # Get the default branch (it's not always 'master'... there are other cases like 'gh-pages' for GitHub pages for example)
      DEFAULT_BRANCH="$(git remote show origin | sed -n 's| *HEAD branch: ||p')"

      # Checkout the default branch or exit if it failed (it could happen when there are changed files which prevent changing branch)
      git checkout "$DEFAULT_BRANCH" || return 1

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
        echo "Usage: ''${funcstack[1]} username:branch"
        return
      fi

      GIT_USERNAME="$(echo "$1" | cut --delimiter=':' --fields=1)"
      BRANCH="$(echo "$1" | cut --delimiter=':' --fields=2)"
      REMOTE="$(git config remote.origin.url | sed -e "s|:.*/|:$GIT_USERNAME/|g")"

      # Add a remote for the fork (if one with the same name doesn't already exist)
      if ! git remote get-url "$GIT_USERNAME" > /dev/null 2>&1; then
        git remote add "$GIT_USERNAME" "$REMOTE"
      fi

      # Fetch branches of the fork
      git fetch --tags "$GIT_USERNAME"

      # Checkout the fork's branch
      git checkout "$GIT_USERNAME"/"$BRANCH"

      # Create a local copy of the fork's branch
      git checkout -b "$BRANCH"

      # Set upstream of the branch to be able to pull changes
      git branch --set-upstream-to="$GIT_USERNAME"/"$BRANCH" "$BRANCH"
    }
  '';
}
