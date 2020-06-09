# System configuration for maintaining my packages on the Open Build Service

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # For Rust packages (with cargo vendor)
    cargo
    python37Packages.osc
    # For Ruby packages (by installing the `gem2rpm` gem)
    ruby
    # TODO Package this - https://pypi.org/project/spec_cleaner/
    # spec-cleaner
  ];
}
