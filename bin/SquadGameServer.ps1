# This script is intended to be run BEFORE a server instance has been started
#
# Author: Deutsche Squad Gemeinschaft
# License: GPLv3
#
#requires -Version 3
using module '../src/instance/instance.psm1'

PARAM (
  [string] $instance
)

# Prepare everything first
& "$PSScriptRoot/../src/bootstrap.ps1"

# Run this instance executable
& [Instance]::Executable($instance)
