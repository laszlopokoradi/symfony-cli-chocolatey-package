$programFiles = (${env:ProgramFiles},$null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$env:ChocolateyPackageName"

Remove-Item -Path $installDir -Recurse