# User configuration for VS Code

{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = [
      # TODO
    ];
    userSettings = {
      "extensions.ignoreRecommendations" = true;
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "update.mode" = "none";
    };
  };
}
