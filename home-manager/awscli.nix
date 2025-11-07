# User configuration for AWS CLI

{ config, ... }:

{
  # Do not pollute $HOME with config files
  home.sessionVariables = {
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
  };

  # Install AWS CLI
  programs.awscli.enable = true;

  # Configure AWS CLI with profiles for my AWS personal account and my Scaleway personal account for Object Storage
  xdg.configFile."aws/config".text = ''
    [profile personal]
    # Europe (Frankfurt)
    region = eu-central-1
    # Avoid storing credentials in plain text
    # https://1password.community/discussion/132453/how-to-configure-aws-config-credential-process-op
    credential_process = sh -c "op item get 'AWS - Personal' --format=json --fields=label='Access Key Id',label='Secret Access Key' | jq 'map({key: .label | gsub(\" \"; \"\"), value: .value}) | {Version: 1} + from_entries'"

    # Scaleway
    [profile scaleway]
    region = fr-par
    endpoint_url = https://s3.fr-par.scw.cloud
    # Avoid storing credentials in plain text
    # https://1password.community/discussion/132453/how-to-configure-aws-config-credential-process-op
    credential_process = sh -c "op item get scaleway.com --format=json --fields=label='API Key.Access Key Id',label='API Key.Secret Access Key' | jq 'map({key: .label | gsub(\" \"; \"\"), value: .value}) | {Version: 1} + from_entries'"

    # Scaleway - Object Storage
    [profile scaleway-os]
    region = fr-par
    endpoint_url = https://s3.fr-par.scw.cloud
    # Avoid storing credentials in plain text
    # https://1password.community/discussion/132453/how-to-configure-aws-config-credential-process-op
    credential_process = sh -c "op item get scaleway.com --format=json --fields=label='API Key - Object Storage.Access Key Id',label='API Key - Object Storage.Secret Access Key' | jq 'map({key: .label | gsub(\" \"; \"\"), value: .value}) | {Version: 1} + from_entries'"

    s3 =
      signature_version = s3v4
      max_concurrent_requests = 100
      max_queue_size = 1000
      multipart_threshold = 50MB
      # Edit the multipart_chunksize value according to the file sizes that you
      # want to upload. The present configuration allows to upload files up to
      # 10 GB (1000 requests * 10MB). For example setting it to 5GB allows you
      # to upload files up to 5TB.
      multipart_chunksize = 100MB
  '';

  # Aliases to use the profiles created above
  programs.zsh.initContent = ''
    alias awsp='aws --profile personal'
    alias scw='aws --profile scaleway'
    alias scwos='aws --profile scaleway-os'
  '';
}
