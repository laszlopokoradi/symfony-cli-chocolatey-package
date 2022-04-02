$softwareName = 'symfony-cli'

$programFiles = (${env:ProgramFiles},$null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"

Remove-Item -Path $installDir

Update-SessionEnvironment