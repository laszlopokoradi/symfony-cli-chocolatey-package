$ErrorActionPreference = 'Stop';

$softwareName = 'symfony-cli'
$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"

$url        = "https://github.com/symfony-cli/symfony-cli/releases/download/v$version/symfony-cli_windows_386.zip"
$url64      = "https://github.com/symfony-cli/symfony-cli/releases/download/v$version/symfony-cli_windows_amd64.zip"


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url
  url64bit      = $url64

  softwareName  = $softwareName

  checksum      = '3A620D5E97ABF3D3B75B78EFF3F134C7C592F9AED1FBDC404DAA97F3D013F6F1'
  checksumType  = 'sha256'
  checksum64    = 'F78D0992E7F5EF04F22245A2C5CFC6DE5518476C26E43D058856ED707DF28B69'
  checksumType64= 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $installDir -PathType 'Machine'

Update-SessionEnvironment