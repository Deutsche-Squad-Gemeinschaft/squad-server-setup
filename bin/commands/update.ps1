using module '../../src/steamcmd/steamcmd.psm1'
using module '../../src/utils/path.psm1'

PARAM (
  #[string] $type
)

# Initialize a SteamCMD object
$S = [SteamCMD]::new()

# Verify the instance directory does exist
if (-not [Path]::Exists([Instance]::Directory($instance))) {
  throw "Instance configuration for $instance does not exist!"
}

# Ask for confirmation to delete the Instance
if ($(Read-Host "Are you sure you want to DELETE the instance?") -eq 'y') {
  # Remove configuration directory
  if ([Path]::Exists([Instance]::ConfigDirectory($name))) {
    Remove-Item -Recurse -Path [Instance]::ConfigDirectory($name)
  }
  
  # Remove the runtime directory
  if ([Path]::Exists([Instance]::RuntimeDirectory($name))) {
    Remove-Item -Recurse -Path [Instance]::RuntimeDirectory($name)
  }
}
