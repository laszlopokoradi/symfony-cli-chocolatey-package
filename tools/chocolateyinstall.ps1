$ErrorActionPreference = 'Stop';

$softwareName = 'symfony-cli'
$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"

$url        = "https://github.com/symfony-cli/symfony-cli/releases/download/v$version/symfony-cli_windows_386.zip" # download url, HTTPS preferred
$url64      = "https://github.com/symfony-cli/symfony-cli/releases/download/v$version/symfony-cli_windows_amd64.zip" # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installDir
  url           = $url
  url64bit      = $url64

  softwareName  = $softwareName

  # Checksums are now required as of 0.10.0.
  # To determine checksums, you can get that from the original site if provided.
  # You can also use checksum.exe (choco install checksum) and use it
  # e.g. checksum -t sha256 -f path\to\file
  checksum      = '3A620D5E97ABF3D3B75B78EFF3F134C7C592F9AED1FBDC404DAA97F3D013F6F1'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = 'F78D0992E7F5EF04F22245A2C5CFC6DE5518476C26E43D058856ED707DF28B69'
  checksumType64= 'sha256' #default is checksumType
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $installDir -PathType 'Machine'

Update-SessionEnvironment