$ErrorActionPreference = 'Stop';
$softwareName = 'symfony-cli'
$version = '5.4.8'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"
$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'
$checksum32 = "de330ef30ed5d53f974d9c95b241ec92f2d357f10639da1054c73f46396c768a"
$checksum64 = "7a658edb9b30b1cd0792508bccfaf466157b6bbfffaec2e43f362fbd51a1664b"
$fileName32 = "symfony-cli_windows_386.zip"
$fileName64 = "symfony-cli_windows_amd64.zip"

$url32        = $baseURL + "v" + $version + "/" + $fileName32
$url64      = $baseURL + "v" + $version + "/" + $fileName64

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url32
  url64bit      = $url64

  softwareName  = $softwareName

  checksum      = $checksum32
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $installDir -PathType 'Machine'

Update-SessionEnvironment