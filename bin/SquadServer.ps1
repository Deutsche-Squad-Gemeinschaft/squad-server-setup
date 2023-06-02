# This script is intended to be run BEFORE a server instance has been started
#
# Author: Deutsche Squad Gemeinschaft
# License: GPLv3
#
#requires -Version 3
PARAM (
  [string] $instance
)

using module '../src/instance/instance.psm1'

try {
    # Run the beforeStart event handler
    [Instance]::CallHook($instance, 'beforeStart')

    # Parallelize the following closures in order to emit the afterStart event
    (
        # Run the Squad Server
    ) && (
        # Wait for the server to boot, TODO: watch server log
        Start-Sleep -Seconds 60

        # Run the afterStart event handler
        [Instance]::CallHook($instance, 'afterStart')
    )    
} finally {
    # Run 
}

