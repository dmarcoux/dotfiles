# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

from __future__ import (absolute_import, division, print_function)

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader

# Based on https://wiki.archlinux.org/index.php/Ranger#Archives
class extract(Command):
    def execute(self):
        """
        :extract

        Extract all files in the currently selected archive to a subdirectory (depends on atool)
        """
        import os

        current_archive = self.fm.thisfile

        def refresh(_):
            self.fm.thisdir.load_content()

        descr = "extracting: " + os.path.basename(current_archive.path)
        obj = CommandLoader(args=['aunpack'] + [current_archive.path], descr=descr)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

class toggle_flat(Command):
    """
    :toggle_flat

    Flattens or unflattens the directory view.
    """

    def execute(self):
        self.fm.thisdir.unload()

        if self.fm.thisdir.flat == 0:
            self.fm.thisdir.flat = -1
        else:
            self.fm.thisdir.flat = 0

        self.fm.thisdir.load_content()
