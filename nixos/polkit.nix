# System configuration for Polkit

{ pkgs, ... }:

{
  # Enable Polkit
  security.polkit.enable = true;

  # Install the GNOME-based authentication agent for Polkit
  environment.systemPackages = [ pkgs.polkit_gnome ];

  # Automatically start the authentication agent with systemd
  # From https://nixos.wiki/wiki/Polkit
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };
}
