$softwareName = 'symfony-cli'

$programFiles = (${env:ProgramFiles},$null -ne ${env:ProgramFiles(x86)})[0]
$installDir = "$programFiles\$softwareName"

$statementTerminator = ";"

$actualPath = [System.Collections.ArrayList](Get-EnvironmentVariable -Name 'Path' -Scope 'Machine' -PreserveVariables).split($statementTerminator)

if ($actualPath -contains $installDir)
{
	Write-Host "PATH environment variable contains $installDir. Removing..."
	
	$actualPath.Remove($installDir)	
	$newPath =  $actualPath -Join $statementTerminator

	$cmd = "Set-EnvironmentVariable -Name 'Path' -Value `'$newPath`' -Scope 'Machine'"

    if (Test-ProcessAdminRights) {
        Invoke-Expression $cmd
    } else {
        Start-ChocolateyProcessAsAdmin "$cmd"
    }
}

