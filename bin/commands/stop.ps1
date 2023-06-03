using module '../../src/service/service.psm1'

PARAM (
  [string] $instance
)

# Verify the instance configuration directory does exist
if (Test-Path -Path $this.Directory($instance)) {
    throw "Instance $instance does already exist!"
}

# Create the instance
[Service]::Stop($instance)
