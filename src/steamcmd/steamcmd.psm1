# Author: Deutsche Squad Gemeinschaft
# License: GPLv3
using module '../utils/path.psm1'

<#
 .Synopsis
  Implements everything related to SteamCMD.

 .Description
  This is the "virtual" representation of SteamCMD meant to handle command batching.
#>
class SteamCMD {
  [string] $installDir    = $([Path]::SetupDir('squad'))
  [int] $gameAppId        = 393380
  [int] $serverAppId      = 403240
  [string[]] $subCommands = @()

  SteamCMD ([string] $installDir) {
    $this.installDir = $installDir
  }

  [void] UpdateApp(){
    # Add the sub-command to update the application
    $this.subCommands += "+app_update $($this.appId) validate"
  }

  [void] UpdateMods([string[]] $modIds){
    # Iterate trough the provided Mods
    foreach ($modId in $modIds) {
      # Add the command to update the workshop item 
      $this.subCommands += "+workshop_download_item $($this.gameAppId) $modId"
    }
  }

  [void] Run () {
    # Initialize our command array and start it with the SteamCMD executable
    $CMD = @("steamcmd")

    # Set force_install_dir before login
    $CMD += "+force_install_dir $($this.installDir)"

    # Login anonymously
    $CMD += "+login anonymous"

    # Add all SteamCMD sub-command(s) that have been provided
    $CMD += $this.subCommands -join " "

    # Make sure to quit SteamCMD as the very last command
    $CMD += "+quit"

    # Join the final command and run it
    Invoke-Expression $($CMD -join " ")
  }

  [string[]] KnownMods () {
    # Check what mods are available in the unmodified master
    return Get-ChildItem -Directory -Path [Path]::SetupDir('squad/steamapps/workshop/content/393380') | Select-Object Name
  }
}
