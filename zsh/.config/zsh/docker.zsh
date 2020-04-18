# If Docker is installed, set it up
if type docker > /dev/null 2>&1; then
  ealias doc='docker'
  ealias doccom='docker-compose'

  # If fzf is installed, setup the following aliases
  if type fzf > /dev/null 2>&1; then
    # Select a locally available image and run a new container based on it
    ealias drunf='docker image ls | fzf --header-lines=1 | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker run'

    # Tip: The following aliases are even better when fzf is using this as a default option: --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all
    #      We can quickly select one, multiple or all container(s)

    # Select Docker containers and remove them (with its volumes)
    ealias drmf='docker ps --all | fzf --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker rm --volumes'

    # Select Docker containers and stop them
    ealias dstopf='docker ps | fzf --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker stop'

    # Select a Docker container and start shell in it
    ealias dexecf='docker ps | fzf --header-lines=1 --multi | tr --squeeze-repeats " " | rev | cut --delimiter=" " --fields=1 | rev | xargs --no-run-if-empty -I % bash -c "</dev/tty docker exec --interactive --tty % bash --login"'

    # Select Docker images and remove them
    ealias drmif='docker image ls | fzf --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=3 | xargs --no-run-if-empty docker rmi --force'
  fi
fi
