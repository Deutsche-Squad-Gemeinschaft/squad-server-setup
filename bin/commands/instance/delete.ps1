using module '../../src/steamcmd/steamcmd.psm1'
using module '../../src/utils/path.psm1'

PARAM (
  [string] $instance
)

# Initialize the Instance object
$I = [Instance]::new($instance)

# Ask for confirmation to delete the Instance
if (Read-Host "Are you sure you want to DELETE the instance?" -eq 'y') {
  $I::Delete()
}
