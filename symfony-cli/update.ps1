import-module au
$githubHost = 'https://github.com'
$latestRelease = $githubHost + '/symfony-cli/symfony-cli/releases'

function global:au_SearchReplace {
   @{
        ".\symfony-cli.nuspec" = @{
            "(?i)(^\s*\<version\>).*(\<\/version\>)"           = "`${1}$($Latest.Version)`${2}"
        }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $latestRelease

    $latestChecksumFileLink = $download_page.Links | Where-Object href -match 'checksums.txt$' | ForEach-Object href | select -First 1

    # Define a regular expression pattern to match the version number
    $pattern = "v(\d+\.\d+\.\d+)"
    # Perform the regular expression match
    $match = [regex]::Match($latestChecksumFileLink, $pattern)
    # Extract the version number from the match
    $version = $match.Groups[1].Value


    $latestChecksumFile = Invoke-WebRequest -Uri $githubHost$latestChecksumFileLink

    $filename32 = "symfony-cli_windows_386.zip"
    $filename64 = "symfony-cli_windows_amd64.zip"

    # Define a regular expression pattern to match the checksum and filename
    $pattern = "^(?<checksum>[0-9a-fA-F]+)\s+(?<filename>.*?)$"
    # Perform the regular expression match on each line of the text
    $latestChecksumFile -split "`n" | ForEach-Object {
        $match = [regex]::Match($_, $pattern)
        if ($match.Success -and $match.Groups["filename"].Value -eq $filename32) {
            $checksum32 = $match.Groups["checksum"].Value
        }
        if ($match.Success -and $match.Groups["filename"].Value -eq $filename64) {
            $checksum64 = $match.Groups["checksum"].Value
        }
    }
    
    @{
        Checksum32   = $checksum32
        Checksum64   = $checksum64
        Version = $version
    }
}

update