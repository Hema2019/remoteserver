$computername = Get-Content 'C:\Test.txt'

$sourcefile = "C:\WebDeploy_amd64_en-US.msi"

#This section will install the software 

foreach ($computer in $computername) 

{

$destinationFolder = "\\$computer\C$\Temp"

#This section will copy the $sourcefile to the $destinationfolder. If the Folder does not exist it will create it.

if (!(Test-Path -path $destinationFolder))

{

New-Item $destinationFolder -Type Directory

}

Copy-Item -Path $sourcefile -Destination $destinationFolder

Invoke-Command -ComputerName $computer -Credential Administrator -ScriptBlock { & cmd /c "msiexec.exe /i C:\Temp\WebDeploy_amd64_en-US.msi" /qn ADVANCED_OPTIONS=1 CHANNEL=100}

}