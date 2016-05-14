#requires -version 3

### Detect directory from which was script invoked and sets it as working dir ###
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Write-host "Please run this script by doublecliking in directory, not from Powershell console."
Read-Host "Press Enter if you ran script from parent directory in which you want to recode the subtitles. Script work recursive into subdirectories. (CTRL+C if not)..."
Write-host "Current working directory $dir"
cd $dir
Read-Host "Press any key to continue or CTRL+C to exit..."
######################################################

### .srt file detection ###
$MatchedFiles=$null #Reset file cache variable
$MatchedFiles=Get-ChildItem -Path *.srt -Recurse | Select-Object Name,FullName #Searches for all the files with .srt extension
###########################

### Recoding cycle ###
foreach ($File in $MatchedFiles) {
    [System.IO.File]::WriteAllText($File.Fullname, [System.IO.File]::ReadAllText($File.Fullname, [System.Text.Encoding]::GetEncoding("Windows-1250")), [System.Text.Encoding]::GetEncoding("Unicode"))
    write-host $File.Name "was sucessfuly recoded."
}
######################

Read-Host "Press any key to exit..."