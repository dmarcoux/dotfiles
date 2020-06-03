# User configuration for autorandr

{
  # Enable autorandr. Profiles are specific to hosts, so they're not defined here
  programs.autorandr.enable = true;

  # Since I'm using Redshift, the gamma always varies. It's skipped when detecting changes and applying a profile.
  xdg.configFile."autorandr/settings.ini".text = ''
    [config]
    skip-options=gamma
  '';
}
