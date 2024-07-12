{ pkgs, ... }:

{
  services.xidlehook = {
    enable = true;

    # Reset the inactivity timer once the system wakes up from suspend
    detect-sleep = true;

    # Do not activate when audio is playing
    not-when-audio = true;

    timers = [
      # After 300 seconds (5 minutes) of inactivity (when audio isn't playing), put the screen on standby (~1 second recovery time)
      {
        delay = 300; # seconds
        command = "${pkgs.xorg.xset}/bin/xset dpms force standby";
        canceller = "";
      }
      # After 30 more seconds, lock the screen and suspend the system
      {
        delay = 30; # seconds
        command = "${pkgs.slock}/bin/slock systemctl suspend --check-inhibitors=no";
        canceller = "";
      }
    ];
  };
}
