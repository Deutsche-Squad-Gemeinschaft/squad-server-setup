using module '../../src/steamcmd/steamcmd.psm1'

PARAM (
  #[string] $type
)

$S = [SteamCMD]::new()

# Verify the instance directory does exist
if (Test-Path -Path $this.Directory($instance)) {
  throw "Instance configuration for $instance does not exist!"
}

if ($(Read-Host "Are you sure you want to DELETE the instance?") -eq 'y') {
  # Remove configuration directory
  if (Test-Path -Path[Instance]::ConfigDirectory($name)) {
    Remove-Item -Recurse -Path [Instance]::ConfigDirectory($name)
  }
  
  # Remove the runtime directory
  if (Test-Path -Path[Instance]::RuntimeDirectory($name)) {
    Remove-Item -Recurse -Path [Instance]::RuntimeDirectory($name)
  }
}
# Create the instance
[Instance]::Create($instance)
