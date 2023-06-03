class Path {
    static [string] SetupDir ([string] $path = '.') {
        return [Path]::Normalize($path)
    }

    static [string] Normalize ([string] $path) {
        # Check if a relative path has been provided
        if( -not [IO.Path]::IsPathRooted($path) ) {
            # Make the realtive path an absolute path based on the setup root
            $path = Join-Path -Path [Environment]::GetEnvironmentVariable("SQUAD_SETUP_ROOT") -ChildPath $path
        }

        # Use Join-Path to replace directory seperators
        $path = Join-Path -Path $path -ChildPath '.'

        # Use GetFullPath to replace invalid characters
        return [IO.Path]::GetFullPath($path)
    }

    static [boolean] Exists ([string] $path) {
        return Test-Path -Path [Path]::Normalize($path)
    }
}
