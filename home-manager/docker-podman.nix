{ pkgs, ... }:

{
  # Configure the Docker credential store to use the D-Bus Secret Service (works with the GNOME keyring)
  home.packages = with pkgs; [ docker-credential-helpers ];
  home.file.".docker/config.json".text = builtins.toJSON {
    credsStore = "secretservice";
    auths = {
      "ghcr.io" = { };
    };
  };
}
