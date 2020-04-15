# Configuration for Visual Studio Code (VS Code)

{ pkgs, ... }:

{
  # Environment variables set on shell initialisation
  environment.variables = {
    VISUAL = "code"; # Set VS Code as the default "advanced/graphical" editor
  };

  # Install VS Code
  environment.systemPackages = with pkgs; [vscode];
}
