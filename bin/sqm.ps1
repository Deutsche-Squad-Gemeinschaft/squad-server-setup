# Installation:
# 
# Copy the script into any directory that is in your PATH variable. 
# You can call it from PS using the file name i.e. sqm.
#
# You can find more information on how to edit the PATH and other 
# environment variables on the offical Microsoft documentation:
# https://learn.microsoft.com/en-us/windows/win32/procthread/environment-variables
#
# Usage:
#  > sqm create
#
# Author: Deutsche Squad Gemeinschaft
# License: GPLv3
#
#requires -Version 3
using module '../src/utils/path.psm1'

# Prepare everything first
& "$PSScriptRoot/../src/bootstrap.ps1"

function runCommand ([string] $path, [int] $level = 0) {
  foreach($child in Get-ChildItem $path) {
    # Check if the current argument is a sub-directory
    if ((Get-item $child) -is [System.IO.DirectoryInfo]) {
      # Search sub command using the next argument
      runCommand($child, $level + 1)

      # Stop further search
      break
    }

    # Check if the current argument is a file
    if ((Get-item $child) -is [System.IO.FileInfo]) {
      # Run the command
      & $child @args

      # Stop further search
      break
    }
  }
}

# Try to run the command starting from ./commands directory
runCommand([Path]::SetupDir('bin/commands'))
