# System configuration for VS Code

{ pkgs, ... }:

{
  # Environment variables set on shell initialisation
  environment.variables = {
    VISUAL = "code"; # Set VS Code as the default "advanced/graphical" editor
  };
}
