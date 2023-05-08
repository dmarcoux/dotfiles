# System configuration for DeaDBeeF, a music player

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (deadbeef-with-plugins.override {
      plugins = with deadbeefPlugins; [
        # Control DeaDBeeF with media keys
        mpris2
      ];
    })
  ];
}
