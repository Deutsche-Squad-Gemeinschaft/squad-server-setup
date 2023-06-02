# Author: Deutsche Squad Gemeinschaft
# License: GPLv3

<#
 .Synopsis
  Implements everything related to Squad.

 .Description
  This is the "virtual" representation of Squad and any logic related to it.
#>
class Squad {
    [string]$basePath   = "SquadGame"
    [string]$configPath = "$basePath/ServerConfig"
    [string]$modsPath   = "$basePath/Plugins/Mods"
}
