# System configuration for maintaining my packages on the Open Build Service

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # TODO This package doesn't build anymore in NixOS 22.11
    # python37Packages.osc
    # TODO Package this - https://pypi.org/project/spec_cleaner/
    # spec-cleaner
  ];
}
