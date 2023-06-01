# Author: Deutsche Squad Gemeinschaft
# License: GPLv3

<#
 .Synopsis
  Implements everything related to SteamCMD.

 .Description
  This is the "virtual" representation of SteamCMD meant to handle command batching.
#>
class Steam-CMD {
  [string]$installDir
  [int]$appId = 403240

  [void] updateApp(){
    # TODO
  }

  [void] updateMods([string[]] $modIds){
    # Initialize our command array
    CMD = @()

    # Iterate trough all provided Mods
    foreach ($modId in $modIds) {
      # Add the command to download the workshop item 
      CMD += "+workshop_download_item 393380 $modId"
    }

    # Join all SteamCMD sub-commands and run SteamCMD
    $this.Run($CMD -join " ")
  }

  [void] run ([string] $command) {
    # Initialize our command array and start it with the SteamCMD executable
    CMD = @("steamcmd")

    # Set force_install_dir before login
    CMD += "+force_install_dir $($this.installDir)"

    # Login anonymously
    CMD += "+login anonymous"

    # Add all SteamCMD sub-command(s) that have been provided
    CMD += $command -join " "

    # Make sure to quit SteamCMD as the very last command
    CMD += "+quit"

    # Join the final command and run it
    Invoke-Expression $($CMD -join " ")
  }
}

Export-ModuleMember -Function Steam-CMD