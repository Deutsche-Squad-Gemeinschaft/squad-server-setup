using module '../../src/service/service.psm1'
using module '../../src/utils/path.psm1'

PARAM (
  [string] $instance
)

# Verify the instance configuration directory does exist
if ([Path]::Exists([Instance]::Directory($instance))) {
    throw "Instance $instance does already exist!"
}

# Create the instance
[Service]::Start($instance)
