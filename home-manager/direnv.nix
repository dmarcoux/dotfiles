# User configuration for direnv

{
  programs.direnv = {
    # Install direnv
    enable = true;
    # Configure direnv
    config = {
      global = {
        # Do not output the `export` messages about the changes in loaded/unloaded environment variables after entering/exiting a directory with an .envrc file
        hide_env_diff = true;
      };
    };
  };
}
