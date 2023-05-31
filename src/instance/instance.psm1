# Author: Deutsche Squad Gemeinschaft
# License: GPLv3

<#
 .Synopsis
  Implements everything related to the server instances.

 .Description
  This is the "virtual" representation of a server instance.
#>
class Instance {
    [string]$name

    Instance ([string] $name) {
        $this.name = $name;

        # Make sure the instance directory does exist
    }

    static [Instance] Create ([string] $name) {
        # Create instance directory
        New-Item -ItemType Directory -Force -Path C:\Path\That\May\Or\May\Not\Exist

        # Return instance of Instance
        return [Instance]::new($name)
    }
}

Export-ModuleMember -Function Instance
