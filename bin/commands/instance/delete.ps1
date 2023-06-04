using module '../../src/steamcmd/steamcmd.psm1'
using module '../../src/utils/path.psm1'

PARAM (
  [string] $instance
)

# Verify the instance directory does exist
if (-not [Path]::Exists([Instance]::Directory($instance))) {
  throw "Instance configuration for $instance does not exist!"
}

# Ask for confirmation to delete the Instance
if (Read-Host "Are you sure you want to DELETE the instance?" -eq 'y') {
  # Remove configuration directory
  if ([Path]::Exists([Instance]::ConfigDirectory($instance))) {
    Remove-Item -Recurse -Path [Instance]::ConfigDirectory($instance)
  }
  
  # Remove the runtime directory
  if ([Path]::Exists([Instance]::RuntimeDirectory($instance))) {
    Remove-Item -Recurse -Path [Instance]::RuntimeDirectory($instance)
  }
}
