import-module au
$githubHost = 'https://github.com'
$latestRelease = $githubHost + '/symfony-cli/symfony-cli/releases'

function global:au_SearchReplace {
   @{
        ".\symfony-cli.nuspec" = @{
            "(?i)(^\s*\<version\>).*(\<\/version\>)" = "`${1}$($Latest.Version)`${2}"
            "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}[Changelog]($latestRelease/tag/v$($Latest.Version))`${2}"
        }
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }    
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $latestRelease

    $latestChecksumFileLink = $download_page.Links | Where-Object href -match 'checksums.txt$' | ForEach-Object href | Select-Object -First 1

    $version = Get-VersionFromLatestChecksumFileLink -latestChecksumFileLink $latestChecksumFileLink

    $latestChecksumFile = Invoke-WebRequest -Uri $githubHost$latestChecksumFileLink

    $filename32 = "symfony-cli_windows_386.zip"
    $filename64 = "symfony-cli_windows_amd64.zip"

    $checksum32 = Get-ChecksumFor -checksumFile $latestChecksumFile -fileName $filename32
    $checksum64 = Get-ChecksumFor -checksumFile $latestChecksumFile -fileName $filename64

    return @{
        Checksum32   = $checksum32
        Checksum64   = $checksum64
        Version = $version
    }
}

function Get-VersionFromLatestChecksumFileLink {

    param(
        $latestChecksumFileLink
    )

    # Define a regular expression pattern to match the version number
    $pattern = "v(\d+\.\d+\.\d+)"
    # Perform the regular expression match
    $match = [regex]::Match($latestChecksumFileLink, $pattern)
    # Extract the version number from the match
    return $match.Groups[1].Value
}

function Get-ChecksumFor {
    param (
        $checksumFile,
        $fileName
    )

    $pattern = "^(?<checksum>[0-9a-fA-F]+)\s+(?<filename>.*?)$"
    # Perform the regular expression match on each line of the text
    $checksumFile -split "`n" | ForEach-Object {
        $match = [regex]::Match($_, $pattern)
        if ($match.Success -and $match.Groups["filename"].Value -eq $filename) {
            return $match.Groups["checksum"].Value
        }
    }
}

update -ChecksumFor none