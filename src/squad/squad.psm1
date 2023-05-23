# Author: Deutsche Squad Gemeinschaft
# License: GPLv3

<#
 .Synopsis
  Implements everything related to Squad (servers).

 .Description
  This is the "virtual" representation of a Squad server instance.
#>
class Squad {
    [string]$basePath   = "SquadGame"
    [string]$configPath = "$basePath/ServerConfig"
    [string]$modsPath   = "$basePath/Plugins/Mods"
}

Export-ModuleMember -Function Squad
