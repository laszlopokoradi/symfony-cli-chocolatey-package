$ErrorActionPreference = 'Stop'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$env:ChocolateyPackageName"

$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'
$checksum32 = "07c8472a20c3218ac3140d5fc2fca52de6c49ace32e27d7978d096464fc92883"
$checksum64 = "b8f59ff03810546022bd74a8db4c69d81a7a9eac51ff2fd26ee7b54c94c77dbe"
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