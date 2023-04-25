$ErrorActionPreference = 'Stop'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$env:ChocolateyPackageName"

$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'

$checksum32 = '2378bdf1894cb053371395807fcf4e501023247384c8e82f1ad494c76bfc2609'
$checksum64 = '40efcec79577d9eb89de7eb62d097dcbfa0565989517ac6ffb453ed3123fde61'

$fileName32 = "symfony-cli_windows_386.zip"
$fileName64 = "symfony-cli_windows_amd64.zip"

$url32      = $baseURL + "v" + $env:ChocolateyPackageVersion + "/" + $fileName32
$url64      = $baseURL + "v" + $env:ChocolateyPackageVersion + "/" + $fileName64

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url32
  url64bit      = $url64

  softwareName  = $env:ChocolateyPackageName

  checksum      = $checksum32
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $installDir -PathType 'Machine'

Update-SessionEnvironment
