# Author: Deutsche Squad Gemeinschaft
# License: GPLv3

<#
 .Synopsis
  Implements everything related to Services.

 .Description
  This Class i meant to abstract usage of SystemD / sc.exe.
#>
class Service {
    static [void] Start([string] $name){
        if ($global:IsWindows) {
            SC start "squad-$name"
        } elseif ($global:IsLinux) {
            systemctl --user start "$name.service"
        } else {
            throw 'The currently used operating system is not supported!'
        }
    }

    static [void] Restart([string] $name){
        if ($global:IsWindows) {
            [Service]::stop($name)
            [Service]::start($name)
        } elseif ($global:IsLinux) {
            systemctl --user restart "$name.service"
        } else {
            throw 'The currently used operating system is not supported!'
        }
    }

    static [void] Stop([string] $name){
        if ($global:IsWindows) {
            SC stop "squad-$name"
        } elseif ($global:IsLinux) {
            systemctl --user stop "$name.service"
        } else {
            throw 'The currently used operating system is not supported!'
        }
    }

    static [void] Status([string] $name){
        if ($global:IsWindows) {
            SC query "squad-$name"
        } elseif ($global:IsLinux) {
            systemctl --user status "$name.service"
        } else {
            throw 'The currently used operating system is not supported!'
        }
    }

    static [void] Create ([string] $name) {
        if ($global:IsWindows) {
            SC create "squad-$name" \
                -displayname "Squad Server Instance $name"  \
                -binpath "$(Join-Path -Path [Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT") -ChildPath "bin/SquadGameServer.ps1") -instance $name" \
                -type own \
                -start auto
        } elseif ($global:IsLinux) {
            # Create user services directory if it does not already exist
            New-Item -ItemType Directory -Force -Path "$([Environment]::GetEnvironmentVariable('HOME'))/.config/systemd/user"

            # Build the service file path for further use
            $serviceFile = '$HOME/.config/systemd/user/squad-$name.service'

            # Create a new SystemD user service definition
            New-Item $serviceFile

            # Write the SystemD service definition to the newly created file
            Set-Content $serviceFile @"
[Unit]
Description=Squad Server Instance $name
After=network.target

[Service]
WorkingDirectory=$([Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT"))/runtimes/$name
Type=simple
TimeoutSec=300
ExecStartPre=$([Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT"))/bin/prepare.ps1
ExecStart=$([Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT"))/bin/SquadGameServer.ps1 -instance $name
ExecStop=/bin/kill -2 `$MAINPID
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
"@
        } else {
            throw 'The currently used operating system is not supported!'
        }
    }
}
