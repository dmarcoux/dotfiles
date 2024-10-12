{
  programs.bash.initExtra = ''
    alias dc='devcontainer'

    alias doc='docker'
    alias pod='podman'
    alias doccom='docker-compose'
    alias podcom='podman-compose'

    # Start a Docker/Podman container for projects without a Docker/Podman setup (ports are mapped directly on the host, so anything running inside the container is accessible on the host)
    alias drunb='docker run -v "$PWD:/app" --net="host" -it ruby:"$(cat .ruby-version)" bash'
    alias prunb='podman run --volume "$PWD:/app" --workdir=/app --rm --network="host" -it ruby:"$(cat .ruby-version)" bash'

    # Select a locally available Docker/Podman image and run a new Docker/Podman container based on it
    alias drunf='docker image ls | fzf --header="Select a Docker image to run a Docker container based on it" --header-lines=1 | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker run'
    alias prunf='podman image ls | fzf --header="Select a Podman image to run a Podman container based on it" --header-lines=1 | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman run'

    # Tip: The following aliases are even better when fzf is using this as a default option: --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all
    #      We can quickly select one, multiple or all option(s)

    # Select Docker/Podman containers and remove them (with their volumes)
    alias drmf='docker ps --all | fzf --header="Select Docker containers to remove (with their volumes)" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker rm --volumes'
    alias prmf='podman ps --all | fzf --header="Select Podman containers to remove (with their volumes)" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman rm --volumes'

    # Select Podman pods and remove them (with their containers)
    alias pprmf='podman pod ps | fzf --header="Select Podman pods to remove (with their containers)" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman pod rm --force'

    # Select Docker/Podman containers and stop them
    alias dstopf='docker ps | fzf --header="Select Docker containers to stop" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty docker stop'
    alias pstopf='podman ps | fzf --header="Select Podman containers to stop" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty podman stop'

    # Select a Docker/Podman container and start shell in it
    alias dexecf='docker ps | fzf --header="Select a Docker container and start shell in it" --header-lines=1 --multi | tr --squeeze-repeats " " | rev | cut --delimiter=" " --fields=1 | rev | xargs --no-run-if-empty -I % bash -c "</dev/tty docker exec --interactive --tty % bash --login"'
    alias pexecf='podman ps | fzf --header="Select a Podman container and start shell in it" --header-lines=1 --multi | tr --squeeze-repeats " " | rev | cut --delimiter=" " --fields=1 | rev | xargs --no-run-if-empty -I % bash -c "</dev/tty podman exec --interactive --tty % bash --login"'

    # Select Docker/Podman images and remove them
    alias drmif='docker image ls | fzf --header="Select Docker images to remove" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=3 | xargs --no-run-if-empty docker rmi --force'
    alias prmif='podman image ls | fzf --header="Select Podman images to remove" --header-lines=1 --multi | tr --squeeze-repeats " " | cut --delimiter=" " --fields=3 | xargs --no-run-if-empty podman rmi --force'
  '';
}
