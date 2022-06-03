$ErrorActionPreference = 'Stop'

$programFiles = (${env:ProgramFiles}, $null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$env:ChocolateyPackageName"

$baseURL    = "https://github.com/symfony-cli/symfony-cli/releases/download/"

$checksumType = 'sha256'
$checksum32 = "966d7b18d8c02f3236fa2e2a7336ea846c5b62f611c4284b4536754402042f24"
$checksum64 = "f7a7898788375c3c311addb6c38962e89b442a45c0c6c7c5257947026a1a5438"
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