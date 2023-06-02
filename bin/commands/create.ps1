PARAM (
  [string] $instance
)

using module '../../src/instance/instance.psm1'

# Verify the instance folder does not already exist
if (Test-Path -Path $this.Directory($instance)) {
    throw "Instance $instance does already exist!"
}

# Create the instance
[Instance]::Create($instance)