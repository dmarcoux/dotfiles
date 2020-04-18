# Configuration for git

{ pkgs, ... }:

{
  # Install git packages
  environment.systemPackages = with pkgs; [
    gitMinimal # Just git
    gitAndTools.hub # Makes git easier to use with GitHub
  ];
}
