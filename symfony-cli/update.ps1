import-module au

$latestRelease = 'https://github.com/symfony-cli/symfony-cli/releases/latest'

function global:au_SearchReplace {
    $releaseNotes = """
    [Changelog](https://github.com/symfony-cli/symfony-cli/releases/tag/$(Latest.Version))

    * chore: Update supported Platform.sh services (@github-actions[bot])
    * chore: Update supported Platform.sh services (@github-actions[bot])
    * Fix inconsistent error message in book requirements check, fix #287 (@tucksaun)
    * Bump deps (@fabpot)
    * Bump deps (@fabpot)
    * Add COMPOSER_MEMORY_LIMIT=-1 when running Composer (@tucksaun)
    """

   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\symfony-cli.nuspec" = @{
            "(?i)(^\s*\<version\>).*(\<\/version\>)"           = "`${1}$($Latest.Version)`${2}"
            "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)"           = "`${1}$($releaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $latestRelease

    $checksum32   = $download_page.links | ? href -match '.msi$' | % href | select -First 1
    $checksum64   = $url64 -replace 'x64.msi$', 'x86.msi'
    $version = (Split-Path ( Split-Path $url32 ) -Leaf).Substring(1)

    @{
        Checksum32   = $checksum32
        Checksum64   = $checksum64
        Version = $version
    }
}

update