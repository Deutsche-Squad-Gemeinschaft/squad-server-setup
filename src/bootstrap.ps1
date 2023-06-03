# Set the path to the setup root directory
[Environment]::SetEnvironmentVariable("SQUAD_SETUP_ROOT", $(Join-Path -Path $PSScriptRoot -ChildPath ".."))
