$ErrorActionPreference = 'Stop';
$softwareName = 'symfony-cli'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"
$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'
$checksum   = "453b00c27c770ce7f16ad8215e4026ac8b4065f870b2c1b5cd66e2270895f496"
$fileName   = "symfony-cli_windows_386.zip"
$checksum64 = "6215248289dd53ca40ad5a79898a2bde4849a3842171d8a325f97956575eb48f"
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