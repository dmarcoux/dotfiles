{ lib, buildGoModule, fetchFromGitHub, pkg-config, alsa-lib }:

buildGoModule rec {
  pname = "teamus";
  version = "45d50d07d82243241a7fb47bacc44290834783b3";

  src = fetchFromGitHub {
    owner = "aretrosen";
    repo = "teamus";
    rev = "45d50d07d82243241a7fb47bacc44290834783b3";
    hash = "sha256-SzLSSgQua7xQHNmdwQ8ahHjOr7O8rvp9hR+iNSQ2I60=";
  };

  # Dependencies that should only exist in the build environment
  nativeBuildInputs = [
    pkg-config
  ];

  # Dependencies that should exist in the runtime environment
  buildInputs = [
    alsa-lib
  ];

  vendorHash = "sha256-uWQjy0w3/DYewmjRhS7+/+4IgTy83aUngcRr3jZYm4I=";

  meta = with lib; {
    description = "Dead simple terminal music player written in go";
    homepage = "https://github.com/aretrosen/teamus";
    license = licenses.mit;
    maintainers = with maintainers; [ dmarcoux ];
  };
}
