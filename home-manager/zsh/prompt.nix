{
  programs.zsh.initExtra = ''
    # Zsh package for version control systems
    autoload -Uz vcs_info

    # Only for Git
    # with the format being: " branch_name "
    zstyle ':vcs_info:*' formats " %b " enable git

    # Call the package in a pre-command
    precmd() { vcs_info }

    # Enable command substitution in the prompt
    setopt prompt_subst

    # %n -> username
    # %~ -> path
    # %F{green} -> set the foreground color to green
    # ''${vcs_info_msg_0_}% -> git information, see above
    # %f -> reset foreground color to the default
    # Anything else is displayed as it is (For example, @)
    PROMPT='[%n@%~]%F{green}''${vcs_info_msg_0_}% %f$ '
  '';
}
