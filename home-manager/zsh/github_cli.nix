{
  programs.zsh.shellAliases = {
    #   Pass GH_TOKEN with personal access token to avoid storing GitHub credentials ('man gh-auth-login' for details)
    #   Generate a personal access token at https://github.com/settings/tokens/new
    gh = "GH_TOKEN=\"$(op read 'op://Personal/github.com/CLI Access Token')\" gh";
  };

  programs.zsh.initContent = ''
    # For the current branch, open the web browser to create a pull request on GitHub
    ealias ghpr='gh pr create --web'

    # Fork a Git repository. It clones the repository, creates the fork on GitHub and sets remotes
    # This is function is only to have something more convenient to type and be consistent in how I setup forks
    fork_repo() {
      if [ -z "$1" ]; then
        # Display usage
        echo "Usage: ''${funcstack[1]} git@github.com:username/repo.git"
        return
      fi

      # Remotes:
      # upstream is well... the upstream repository (surprise!!!)
      # origin is the newly created fork
      GH_TOKEN="$(op read 'op://Personal/github.com/CLI Access Token')" gh repo fork $1 --clone=true --remote=true
    }
  '';
}
