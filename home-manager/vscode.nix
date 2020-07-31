# User configuration for VS Code

{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = [
      # TODO
    ];
    userSettings = {
      "editor.renderWhitespace" = "all";
      "editor.tabCompletion" = "on";
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "extensions.ignoreRecommendations" = true;
      "git.enabled" = true;
      "search.quickOpen.includeHistory" = false;
      "search.smartCase" = true;
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "update.mode" = "none";
      "workbench.activityBar.visible" = false;
      "workbench.colorTheme" = "Solarized Light";
      "workbench.commandPalette.history" = 0;
      "workbench.editor.enablePreview" = false;
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.startupEditor" = "none";
    };
  };
}
