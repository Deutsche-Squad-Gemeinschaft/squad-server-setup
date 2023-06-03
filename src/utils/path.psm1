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

    static [void] stow ([string] $directory, [string] $target, [string[]] $ignore = @()) {
        function targetPath([string] $path) {
            # Remove base path of the provided path
            $relativePath = Resolve-Path -Relative -Path $path

            # Build absolute target path
            return Join-Path -Path $target -ChildPath $relativePath
        }

        function linkRecursive([string] $path) {
            # Get all directories and files in the current path
            $children = Get-ChildItem -Path $path

            # Process all children in parallel
            $children | ForEach-Object -Parallel {
                # Set Child for human readability
                $child = $_

                # Check if Child is ignored
                if ($child -in $ignore) {
                    # Do not process ignored children
                    return
                }

                # Check if the current Child is a directory
                if ((Get-item $child) -is [System.IO.DirectoryInfo]) {
                    # Search sub command using the next argument
                    linkRecursive($child)
                }
                
                # Check if the current Child is a file
                elseif ((Get-item $child) -is [System.IO.FileInfo]) {
                    # Link the file to the target directory
                    New-Item -ItemType SymbolicLink -Path $child -Target targetPath($child)
                }
            }
        }

        # Use the provided directory as cwd
        Set-Location -Path $directory

        # Start recursion at the provided directory
        linkRecursive($directory)
    }
}
