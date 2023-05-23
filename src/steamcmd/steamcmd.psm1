# Author: Deutsche Squad Gemeinschaft
# License: GPLv3

<#
 .Synopsis
  Implements everything related to SteamCMD.

 .Description
  This is the "virtual" representation of SteamCMD meant to handle command batching.
#>
class Steam-CMD {
    [int]$appId   = 403240
}

Export-ModuleMember -Function Steam-CMD