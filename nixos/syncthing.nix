# System configuration for Syncthing

{
  services.syncthing = {
    # Start Syncthing
    enable = true;
    # To run as my user, this avoids permission issues. The group stays syncthing, so the service also has access to the files.
    user = "dany";
    # Web UI is reachable at this address
    guiAddress = "localhost:8384"; # Same as the default, I just want to have this explicit in case I forget the port...
    # The path where synchronised directories will exist
    dataDir = "/home/dany/syncs";
    # Peers/devices which Syncthing should communicate with
    settings.devices = {
      # TODO: My phone's Android version prevents the Syncthing from syncing with other devices... the phone can only send data, not receive.
      # phone = {
      #   id = "Y4ZDZAR-P6X4LVU-5YCZSXG-5JOMAZR-KCQLBGL-PSTB53G-MDE5VFK-44VSGQY";
      #   name = "Phone";
      # };
      server = {
        id = "STQSHMX-WFT5HRH-PY52L6N-RNYHONI-PTVGHUI-HGWCCDH-37EENYG-FNXDHA7";
        name = "files.dmarcoux.com";
      };
    };
    # Override any device added through the web UI, only those defined above persist
    overrideDevices = true;
    # Folders which should be shared by Syncthing
    settings.folders = {
      # Sync for https://obsidian.md/
      "obsidian" = {
        # Path of the folder to sync
        path = "~/obsidian";
        # Sharing with the following devices
        devices = [ "server" ];
      };
      # My music collection
      "music" = {
        # Path of the folder to sync
        path = "~/music";
        # Sharing with the following devices
        devices = [ "server" ];
      };
    };
    # Override any folder added through the web UI, only those defined above persist
    overrideFolders = true;
  };
}
