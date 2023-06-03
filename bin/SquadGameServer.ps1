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

try {
    $I = [Instance]::new($instance)

    # Run the beforeStart event handler
    $I::CallHook('beforeStart')

    # Parallelize the following closures in order to emit the afterStart event
    {
        # Run the Squad Server
        $I::Run()
    } && {
        # Wait for the server to boot, TODO: watch server log
        Start-Sleep -Seconds 60

        # Run the afterStart event handler
        $I::CallHook('afterStart')
    }
} finally {
    # Run 
}

