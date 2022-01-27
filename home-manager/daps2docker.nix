# Setup daps2docker for work

{ config, ... }:

{
   # FIXME: Somehow, even with mkOutOfStoreSymlink, it does create a symlink, but if the source file changes, it's not reflected in `bin/daps2docker`...
   #        The fix is to rebuild.
   # The symlink is going to be broken if https://github.com/opensuse/daps2docker isn't cloned under /home/dany/projets/
   home.file."bin/daps2docker".source = config.lib.file.mkOutOfStoreSymlink "/home/dany/projets/daps2docker/daps2docker.sh";
}
