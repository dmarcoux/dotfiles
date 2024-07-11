{
  # Certificate generated and exported in both PFX and PEM formats with the commands:
  # `dotnet dev-certs https --clean`
  # `dotnet dev-certs https --format PFX --export-path ~/dotfiles/nixos/dotnet-localhost.pfx --password MySuperPassword`
  # `dotnet dev-certs https --format PEM --export-path ~/dotfiles/nixos/dotnet-localhost.crt --password MySuperPassword`
  #
  # The private key `dotnet-localhost.key` is also exported when the certificate is exported in PEM format.
  # Since the certificate is only for localhost/development, I track all files (even the private key)
  # in Git to be able to use them in .NET projects whenever needed, like in Docker containers for example.
  #
  # The certificate is stored at `~/.dotnet/corefx/cryptography/x509stores/my/`.
  #
  # I first thought that the commands above didn't work since they output
  # `A valid HTTPS certificate is already present.` even though they do export
  # the certificate. This output is meant to tell us that a certificate already
  # exists and that it was exported.
  #
  # Import the certificate back in the .NET tools with:
  # `dotnet dev-certs https --clean --import ~/dotfiles/nixos/dotnet-localhost.pfx --password MySuperPassword`
  #
  # For the certificate to be recognized by applications, the certificate
  # in Pem format is imported below. Its content was simply pasted below.
  security.pki.certificates = [ ''
    -----BEGIN CERTIFICATE-----
    MIIDDDCCAfSgAwIBAgIIArP0lRU75CAwDQYJKoZIhvcNAQELBQAwFDESMBAGA1UE
    AxMJbG9jYWxob3N0MB4XDTI0MDcxMTA3MzcyNloXDTI1MDcxMTA3MzcyNlowFDES
    MBAGA1UEAxMJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
    AQEAw26uiq6le/AENo3rJ9AknXzjfJ7dJRDw/+ac06F/h0s+SomHJVlMkgqSlw6d
    wDKnhPxej4iP/8vY6yHjGKJUpmnijmLYuTjmSqcG8riqzcNsYHEMdxerz7yabVMN
    JCnVZaaK/IlUS9EkrN1JgsGyEGDTS+mebm8vnMHSiBLVKZLEl+KzMX8Illl7QjAX
    NMFSQ8yKEPy91c2p8XJ7IK5szTpCEZgdSye1MQ+xziuAJCy1KKS6JZyxC7scDt3I
    8AmqlSixUblQYgdA8S/Lt4Dw/QG7upsWbm6nOZKn4Ql3mK2AgcFdyEtYRimPisE9
    rOS+nRJr6tRTQ2hXPH246+FJlQIDAQABo2IwYDAMBgNVHRMBAf8EAjAAMA4GA1Ud
    DwEB/wQEAwIFoDAWBgNVHSUBAf8EDDAKBggrBgEFBQcDATAXBgNVHREBAf8EDTAL
    gglsb2NhbGhvc3QwDwYKKwYBBAGCN1QBAQQBAjANBgkqhkiG9w0BAQsFAAOCAQEA
    ieu6+MzRA2NB7c0CyHAGPrzvAsxuvNyA7XjA+A6GloNrHAXAqNweHVFOJ6pnFtbX
    2+1c0cqMuRVKk4KBT+Tx0we9cTrQdAoDeTVKmqDTwXoa4Vcth0g1VHYXgJDVonAz
    Fj4rmnOWskZgwECeFW6ADoipjelnn3kYf3kIte4tgw/iyF5n7ViQ9587jRGfDQ+I
    2MmTWz+vvMP2DvPBBA3rGDecpRxROEhbe5clJ94/rT756cJAtiLspMwJc3fijd9A
    07ki0yJTQNGmZAtiiNWbweCXQk6M4ufg3PGOSgHzOpXz9fCvhOsmoww20Az3C62a
    Lm+vpSvkdYPVKUMckb9O7g==
    -----END CERTIFICATE-----
  '' ];

}
