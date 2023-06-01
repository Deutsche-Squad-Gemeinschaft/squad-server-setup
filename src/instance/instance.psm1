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
        if (-Not (Test-Path -Path $this.Directory())) {
            throw "Could not initialize Instance, directory $($this.Directory()) does not exist!"
        }
    }

    static [Instance] Create ([string] $name) {
        # Create instance directory
        New-Item -ItemType Directory -Force -Path $this.Directory()

        # Return instance of Instance
        return [Instance]::new($name)
    }

    [string] Directory() {
        return Join-Path -Path [Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT") -ChildPath "instances/$($this.name)"
    }
}
