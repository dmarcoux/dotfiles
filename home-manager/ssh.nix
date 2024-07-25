# User configuration for ssh

{
  programs.ssh = {
    enable = true;

    # Keep SSH sessions alive by sending, every minute, a keep-alive signal to hosts
    serverAliveInterval = 60;

    # Use the 1Password SSH agent for all hosts
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
}
