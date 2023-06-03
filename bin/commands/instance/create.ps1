using module '../../src/instance/instance.psm1'

PARAM (
  [string] $instance
)

# Verify the instance directory does not already exist
if (Test-Path -Path $this.Directory($instance)) {
    throw "Instance $instance does already exist!"
}

# Create the instance
[Instance]::Create($instance)
