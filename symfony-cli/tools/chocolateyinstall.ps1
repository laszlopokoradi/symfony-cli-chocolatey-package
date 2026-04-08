$ErrorActionPreference = 'Stop'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$env:ChocolateyPackageName"

$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'

$checksum32 = 'e77d987cc1c4fcac906e70ec1cadfac8c575c04ce1d52aaa4d9a21cd7f803c79'
$checksum64 = '232a4e8c314804ed4fa59f957ab6764172d8d07e30cc3bfa6427e708b029f959'

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
