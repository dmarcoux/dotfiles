{ pkgs, config, ... }:

{
  home.file."bin/backup-keys" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      # Backup GPG and SSH keys under dotfiles/backup/$HOSTNAME/

      # -e: Exit immediately if a command exits with a non-zero status
      # -u: Exit on unset variables
      # -x: Write to standard error a trace for each command after it expands the command and before it executes it
      set -eux

      BACKUP_DIR="${config.home.homeDirectory}/dotfiles/backup/$HOSTNAME/keys"

      mkdir --parents "$BACKUP_DIR"

      echo 'Backup GPG and SSH keys?'
      select choice in "Yes" "No"; do
        case $choice in
          Yes ) echo 'Exporting GPG keys and their trusts'
                gpg --export-secret-keys --armor --output "$BACKUP_DIR/secrets.asc"
                gpg --export-ownertrust > "$BACKUP_DIR/otrust.txt"

                echo 'Exporting SSH keys'
                cp ~/.ssh/*id_rsa* "$BACKUP_DIR"

                echo 'Archiving keys'
                (cd "$BACKUP_DIR" && tar --create --file=keys.tar secrets.asc otrust.txt ./*id_rsa*)

                echo 'Encrypting the tar archive'
                (cd "$BACKUP_DIR" && gpg --symmetric --cipher-algo=AES256 keys.tar)

                echo 'Removing exported GPG/SSH keys and the unencrypted tar archive'
                (cd "$BACKUP_DIR" && rm secrets.asc otrust.txt ./*id_rsa* keys.tar)

                echo 'Reloading GPG agent to clear the cached passphrase'
                gpg-connect-agent reloadagent /bye 1> /dev/null

                break ;;
          No ) break ;;
        esac
      done
    '';
  };
}
