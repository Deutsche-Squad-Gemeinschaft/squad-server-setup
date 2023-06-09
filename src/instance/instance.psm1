# Author: Deutsche Squad Gemeinschaft
# License: GPLv3
using module '../service/service.psm1'
using module '../utils/path.psm1'

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
        if (-not [Path]::Exists([Instance]::ConfigDirectory($this.name))) {
            throw "Could not initialize Instance, config directory $($this.ConfigDirectory($this.name)) does not exist!"
        }
    }

    [void] CallHook ([string] $hook) {
        # Build the file path for the event hook
        $filePath = [Path]::SetupDir("instances/$($this.name)/afterStart")

        # make sure the event hook does exist
        if ([Path]::Exists($filePath)) {
            # Run the event hook
            & $filePath
        }
    }

    [void] Prepare () {
        # Link game files
        [Path]::stow([Path]::SetupDir('squad'), [Instance]::RuntimeDirectory($this.name), @())
    }

    [void] Delete () {
        # Delete the Instance service file / definition
        [Service]::Delete($this.name)

        # Remove configuration directory
        Remove-Item -Recurse -Path [Instance]::ConfigDirectory($this.name)
        
        # Remove the runtime directory (if it exists)
        if ([Path]::Exists([Instance]::RuntimeDirectory($this.name))) {
            Remove-Item -Recurse -Path [Instance]::RuntimeDirectory($this.name)
        }
    }

    static [Instance] Create ([string] $name) {
        # Create Instance directory if it does not already exist
        New-Item -ItemType Directory -Force -Path [Instance]::ConfigDirectory($name)

        # Populate new Instance directory with base files from the skeleton
        Copy-Item [Instance]::ConfigDirectory(".skeleton") -Destination [Instance]::ConfigDirectory($name)

        # Create the Instance service file
        [Service]::Create($name)

        # Return instance of Instance
        return [Instance]::new($name)
    }

    static [string] ConfigDirectory ([string] $name) {
        return [Path]::SetupDir("configs/$name")
    }

    static [string] RuntimeDirectory ([string] $name) {
        return [Path]::SetupDir("runtimes/$name")
    }

    static [string] Executable ([string] $name) {
        if ($global:IsWindows) {
            return [Path]::Normalize("$([Instance]::RuntimeDirectory($name))/SquadGameServer.exe")
        } elseif ($global:IsLinux) {
            return [Path]::Normalize("$([Instance]::RuntimeDirectory($name))/SquadGameServer.sh")
        } else {
            throw 'The currently used operating system is not supported!'
        }
    }
}
