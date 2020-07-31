# User configuration for VS Code

{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = [
      # TODO
    ];
    userSettings = {
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "update.mode" = "none";
    };
  };
}
