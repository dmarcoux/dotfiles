# User configuration for .NET

{ config, ... }:

{
  home.sessionVariables = {
    # Do not pollute $HOME with config files
    DOTNET_CLI_HOME="${config.xdg.dataHome}/dotnet";
    NUGET_PACKAGES="${config.xdg.cacheHome}/NuGetPackages";
  };
}
