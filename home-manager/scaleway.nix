# User configuration for Scaleway

{ pkgs, config, ... }:

{
  # Install Command Line Interface for AWS and S3-compatible services like Scaleway Storage
  home.packages = [ pkgs.awscli2 ];

  # Do not pollute $HOME with config files
  home.sessionVariables = {
    AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
  };

  # Configure AWS CLI to be used with Scaleway Storage
  xdg.configFile."aws/config".text = ''
    [default]
    region = fr-par
    s3 =
      endpoint_url = https://s3.fr-par.scw.cloud
      signature_version = s3v4
      max_concurrent_requests = 100
      max_queue_size = 1000
      multipart_threshold = 50MB
      # Edit the multipart_chunksize value according to the file sizes that you
      # want to upload. The present configuration allows to upload files up to
      # 10 GB (1000 requests * 10MB). For example setting it to 5GB allows you
      # to upload files up to 5TB.
      multipart_chunksize = 100MB
    s3api =
      endpoint_url = https://s3.fr-par.scw.cloud
  '';

  # Aliases to avoid storing credentials in plain text in ~/.aws/credentials, instead passing them inline in environment variables
  # Examples:
  #   Create a bucket
  #     scw s3 mb s3://<bucket_name>
  #   List buckets
  #     scw s3 ls
  #   Uploading files as objects to a bucket
  #     scw s3 cp /datas/test1 s3://<bucket_name>
  #   By default, objects are named after files, but can be renamed
  #     scw s3 cp /datas/test1 s3://<bucket_name>/other-filename
  #   Downloading an object from a bucket
  #     scw s3 cp s3://<bucket_name>/test1.
  #   Uploading an object from one bucket to another bucket
  #     scw s3 cp s3://<bucket_name>/test1 s3://<bucket_name_2
  #   Downloading or uploading an entire bucket to the host/bucket
  #     scw s3 cp s3://<bucket_name> . --recursive
  #     scw s3 cp s3://<bucket_name> s3://<bucket_name_2> --recursive
  #   Synchronising files from current directory to a bucket
  #     scw s3 sync . s3://<bucket_name>
  #   Synchonising a bucket to another bucket
  #     scw s3 sync s3://<bucket_name> s3://<bucket_name_2>
  #   Synchonising a bucket to another bucket, but with a specific storage class like GLACIER (for cold storage) or ONEZONE_IA (for a single data center)
  #     scw s3 sync s3://<bucket_name> s3://<bucket_name_2> --storage-class GLACIER
  #     scw s3 sync s3://<bucket_name> s3://<bucket_name_2> --storage-class ONEZONE_IA
  programs.zsh.initExtra = ''
    alias scw='AWS_ACCESS_KEY_ID=$(op read "op://Personal/scaleway.com/API Key - Object Storage/Access Key ID") AWS_SECRET_ACCESS_KEY=$(op read "op://Personal/scaleway.com/API Key - Object Storage/Secret Key") aws --endpoint-url https://s3.fr-par.scw.cloud'
  '';
}
