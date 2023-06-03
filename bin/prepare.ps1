# This script is intended to be run BEFORE a server instance has been started
#
# Author: Deutsche Squad Gemeinschaft
# License: GPLv3
#
#requires -Version 3
PARAM (
  [string] $instance
)

# Prepare everything first
& "$PSScriptRoot/../src/bootstrap.ps1"

# Clear instance runtime
# TODO: Delete instance runtime directory

# Create runtime structure
# TODO: Copy unmodified Squad server bianry
# TODO: Create directories for Mods & ServerConfig
# TODO: Link everything else using stow
# TODO: Link required mods

# Call beforeStart event handler
# TODO: Execute instances beforeStart if it does exist