$ErrorActionPreference = 'Stop';
$softwareName = 'symfony-cli'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"
$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'
$checksum   = "1e963e86d57c890d8beaaae3d89cf1eb91bb8b26c9447c988d366561df33fe0a"
$fileName   = "symfony-cli_windows_386.zip"
$checksum64 = "a77527beeac8f11b56693d88523e8b32ff9c657a40432159444d0d0f6a0de220"
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