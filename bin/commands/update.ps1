using module '../../src/steamcmd/steamcmd.psm1'
using module '../../src/utils/path.psm1'

PARAM (
  #[string] $type
)

# Initialize a SteamCMD object
$steamCMD = [SteamCMD]::new()

# Update the game files
$steamCMD::UpdateApp()

# Update available mods
$steamCMD::UpdateMods($steamCMD::KnownMods())
