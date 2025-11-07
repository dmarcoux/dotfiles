# Based on https://github.com/nix-community/disko/blob/a08bfe06b39e94eec98dd089a2c1b18af01fef19/example/luks-interactive-login.nix
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda"; # Dual-booting with Windows, which is on /dev/nvme0n1
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # During the installation, create this file with `echo -n "password" > /tmp/secret.key` (-n is needed to ensure there is no trailing newline)
                # The password is in my password manager
                passwordFile = "/tmp/secret.key";
                settings = {
                  # Trim support for SSDs
                  allowDiscards = true;
                };
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
