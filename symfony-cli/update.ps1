import-module au

function global:au_SearchReplace {
    $latestRelease = 'https://github.com/symfony-cli/symfony-cli/releases'

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
    $apiUrl = 'https://api.github.com/repos/symfony-cli/symfony-cli/releases/latest'
    $release = Invoke-RestMethod -Uri $apiUrl

    $version = $release.tag_name -replace '^v', ''

    $checksumAsset = $release.assets | Where-Object { $_.name -eq 'checksums.txt' }
    if (-not $checksumAsset) {
        throw "Checksums file not found in latest release"
    }

    $checksumUrl = $checksumAsset.browser_download_url
    $latestChecksumFile = Invoke-WebRequest -Uri $checksumUrl

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