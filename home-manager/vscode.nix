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
      "git.enabled" = true;
      "search.smartCase" = true;
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "update.mode" = "none";
      "workbench.editor.enablePreview" = false;
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.startupEditor" = "none";
    };
  };
}
