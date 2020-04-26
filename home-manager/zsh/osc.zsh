# If osc is installed, set it up
if type osc > /dev/null 2>&1; then
  # Development OBS instance
  # This depends on having a 'dosc' alias in osc's config (~/.config/osc/oscrc)
  # [http://localhost:3000]
  # aliases = dosc
  # user = Admin
  # pass = opensuse
  alias dosc='osc --apiurl=dosc'

  # Mark file(s) to be added upon next commit
  ealias oa='osc add'

  # Mark {new,deleted} local files to be {added,deleted}
  ealias oar='osc addremove'

  # Select one of the configured repositories for the project and build the project for it
  ealias obf='osc repos | fzf | tr --squeeze-repeats " " | cut --delimiter=" " --fields=1 | xargs --no-run-if-empty osc build --target='

  # Build the project for Leap 15.0
  ealias obl='osc build --target=openSUSE_Leap_15.0/x86_64'

  # Build the project for Tumbleweed
  ealias obt='osc build --target=openSUSE_Tumbleweed/x86_64'

  # Push changes to remote
  ealias oci='osc commit'

  # Check out content from the repository
  ealias oco='osc checkout'

  # Copy a package from a project to another
  ealias ocp='osc copypac'
  # TODO: Snippet to copy a package to my local OBS instance 'osc --apiurl=http://localhost:3000 copypac openSUSE.org:home:REMOTE_OBS_USER REMOTE_PACKAGE home:LOCAL_OBS_USER' (this depends on the interconnect)

  # Generates a diff, comparing local changes against the repository server
  ealias odi='osc diff'

  # Download files referenced via source URL in the project's spec file
  ealias odl='osc service localrun download_files'

  # Create a new package
  ealias omp='osc mkpac'

  # Rebuld all packages for a project
  ealias ora='osc rebuild --all' # then add project name...

  # Mark file(s) to be deleted upon next commit
  ealias orm='osc delete'

  # Clean spec file and display the diff
  ealias osp='spec-cleaner --diff'

  # Submit request to a project
  ealias osr='osc submitrequest'
  # TODO: Snippet to submit request to openSUSE:Factory 'osr devel:project:abc/the_package openSUSE:Factory'

  # Show status of files
  ealias ost='osc status'

  # Show reason why a package got triggered to build
  ealias otr='osc triggerreason'

  # Update a working copy (project or package)
  ealias oup='osc update'

  # Edit the changes file
  ealias ovc='EDITOR="code --wait" osc vc'
fi
