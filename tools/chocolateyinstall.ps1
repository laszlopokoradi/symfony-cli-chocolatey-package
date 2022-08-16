$ErrorActionPreference = 'Stop'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$env:ChocolateyPackageName"

$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'
$checksum32 = "695601fad39e8849a5cdd94e499a10a3d237246864f81fe1e5bcfdb7675d7641"
$checksum64 = "6043bd9ec37f5bae52710c37d6561e5dbdefe3f59bc3af9b331295a355550a67"
$fileName32 = "symfony-cli_windows_386.zip"
$fileName64 = "symfony-cli_windows_amd64.zip"

$url32        = $baseURL + "v" + $env:ChocolateyPackageVersion + "/" + $fileName32
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