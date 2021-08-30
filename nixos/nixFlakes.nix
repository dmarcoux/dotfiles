# Add command `nixFlakes` that serves as a flakes-enabled alias to the `nix` command
# From https://nixos.wiki/wiki/Flakes#Installation_as_an_extra_command

{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];
}
