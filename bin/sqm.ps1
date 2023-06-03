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
PARAM (
  [string]$subCommand
)

# Prepare everything first
& "$PSScriptRoot/../src/bootstrap.ps1"

# Find and run the sub command
if (! $subCommand) {
    foreach($_ in Get-ChildItem $PSScriptRoot\commands -Name) {
        [System.IO.Path]::GetFileNameWithoutExtension($_)
    }
    return
}

& "$PSScriptRoot\Command\$subCommand.ps1" @args