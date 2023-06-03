using module '../../src/instance/instance.psm1'
using module '../../src/utils/path.psm1'

PARAM (
  [string] $instance
)

# Verify the instance directory does not already exist
if ([Path]::Exists([Instance]::Directory($instance))) {
    throw "Instance $instance does already exist!"
}

# Create the instance
[Instance]::Create($instance)
