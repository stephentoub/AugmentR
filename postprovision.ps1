function Set-DotnetUserSecrets {
    param ($path, $lines)
    Push-Location
    cd $path
    dotnet user-secrets clear
    foreach ($line in $lines) {
        $name, $value = $line -split '='
        $value = $value -replace '"', ''
        $name = $name -replace '__', ':'
        if ($value -ne '') {
            dotnet user-secrets set $name $value
        }
    }
    Pop-Location
}

$lines = (azd env get-values) -split "`n"
Set-DotnetUserSecrets -path ".\Backend" -lines $lines
Set-DotnetUserSecrets -path ".\Frontend" -lines $lines
