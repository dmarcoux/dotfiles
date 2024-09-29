# TODO: Submit this package to https://github.com/NixOS/nixpkgs
{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "caffeinate";
  version = "e20985a4b630eb5c76e16c2547da0aba65f097d5";

  src = fetchFromGitHub {
    owner = "rschmukler";
    repo = pname;
    rev = version;
    hash = "sha256-22gQ+rXANrCgaqtji3BAA0ITmEoVua+q4C+KEn5LM90=";
  };

  cargoHash = "sha256-ss0J+L3XWwV96AAuLScYl2FiK4K76XK35mPmDF/TAAg=";

  meta = with lib; {
    description = "Command-line app bringing caffeinate functionality to xidlehook";
    homepage = "https://github.com/rschmukler/caffeinate";
    license = licenses.mit;
    maintainers = with maintainers; [ dmarcoux ];
  };
}
