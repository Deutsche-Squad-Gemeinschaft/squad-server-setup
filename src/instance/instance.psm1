# Author: Deutsche Squad Gemeinschaft
# License: GPLv3

<#
 .Synopsis
  Implements everything related to the server instances.

 .Description
  This is the "virtual" representation of a server instance.
#>
class Instance {
    [string] $name

    Instance ([string] $name) {
        $this.name = $name;

        # Make sure the instance directory does exist
        if (-Not (Test-Path -Path $this.Directory($this.name))) {
            throw "Could not initialize Instance, directory $($this.Directory($this.name)) does not exist!"
        }
    }

    static [Instance] Create ([string] $name) {
        # Create instance directory if it does not already exist
        New-Item -ItemType Directory -Force -Path $this.Directory($name)

        # Populate new instance directory with base files from the skeleton
        Copy-Item $this.Directory(".skeleton") -Destination $this.Directory($name)

        # Return instance of Instance
        return [Instance]::new($name)
    }

    static [string] Directory([string] $name) {
        return Join-Path -Path [Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT") -ChildPath "configs/$name"
    }
}
