$ErrorActionPreference = 'Stop';

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"
$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = $programFiles + "\" + $softwareName

$checksumType = 'sha256'
$checksum   = "3a620d5e97abf3d3b75b78eff3f134c7c592f9aed1fbdc404daa97f3d013f6f1"
$fileName   = "symfony-cli_windows_386.zip"
$checksum64 = "f78d0992e7f5ef04f22245a2c5cfc6de5518476c26e43d058856ed707df28b69"
$fileName64 = "symfony-cli_windows_amd64.zip"

$url        = $baseURL + "v" + $version + "/" + $fileName
$url64      = $baseURL + "v" + $version + "/" + $fileName64

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url
  url64bit      = $url64

  softwareName  = $softwareName

  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $installDir -PathType 'Machine'

Update-SessionEnvironment