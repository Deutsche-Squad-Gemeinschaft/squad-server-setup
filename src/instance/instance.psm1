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
        if (-Not (Test-Path -Path $this.ConfigDirectory($this.name))) {
            throw "Could not initialize Instance, config directory $($this.ConfigDirectory($this.name)) does not exist!"
        }
    }

    [void] CallHook([string] $hook) {
        # Build the file path for the event hook
        $filePath = Join-Path -Path [Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT") -ChildPath "instances/$($this.name)/afterStart"

        # make sure the event hook does exist
        if (Test-Path -Path $filePath) {
            # Run the event hook
            & $filePath
        }
    }

    static [Instance] Create ([string] $name) {
        # Create instance directory if it does not already exist
        New-Item -ItemType Directory -Force -Path [Instance]::ConfigDirectory($name)

        # Populate new instance directory with base files from the skeleton
        Copy-Item [Instance]::ConfigDirectory(".skeleton") -Destination [Instance]::ConfigDirectory($name)

        # Return instance of Instance
        return [Instance]::new($name)
    }

    static [string] ConfigDirectory([string] $name) {
        return Join-Path -Path [Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT") -ChildPath "configs/$name"
    }

    static [string] RuntimeDirectory([string] $name) {
        return Join-Path -Path [Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT") -ChildPath "runtimes/$name"
    }

    static [string] Executable([string] $name) {
        if ($global:IsWindows) {
            return Join-Path -Path [Environment]::RuntimeDirectory($name) -ChildPath "SquadGameServer.exe"
        } elseif ($global:IsLinux) {
            return Join-Path -Path [Environment]::RuntimeDirectory($name) -ChildPath "SquadGameServer.sh"
        } else {
            throw 'The currently used operating system is not supported!'
        }
    }
}
