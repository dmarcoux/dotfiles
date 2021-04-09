# User configuration for starship

{ unstable, ... }:

{
  programs.starship = {
    enable = true;
    # Install starship (using unstable since it's often updated)
    package = unstable.starship;
    settings = {
      # Do not insert blank line between shell prompts.
      add_newline = false;
      # Overwrite the default format to only use modules I want
      #  \\ are for escaping special characters in the generated TOML configuration file
      #  $something is a variable
      #  []() is a text group. For example, the text group [on](red bold) will print a string "on" in bold red
      format = builtins.concatStringsSep "" [
        "\\["
        "$username" # Display the active user's username
        "@"
        "$directory" # Display the path to the current directory
        "\\]"
        "$git_branch" # Display the active branch of the git repository in the current directory
        "$character" # Display a character beside where the text is entered in the terminal
      ];
      # Configure the username module
      username = {
        format = "$user";
        show_always = true; # Always show the username module
      };
      # Configure the directory module
      directory = {
        format = "$path";
        truncate_to_repo = false; # Do not truncate to the root of the git repository that I'm currently in
        truncation_length = 10; # Number of parent directories that the current directory should be truncated to
      };
      # Confgure the character module
      character = {
        success_symbol = "\\$";
        error_symbol = "\\$";
      };
      # Configure the git_branch module
      git_branch = {
        format = " [$branch]($style) ";
        style = "fg:green";
      };
    };
  };
}
