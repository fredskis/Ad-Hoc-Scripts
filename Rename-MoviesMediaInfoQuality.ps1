[CmdletBinding()]
Param()

$mediaInfoCliExe = 'C:\Temp\MediaInfo_CLI_0.7.93_x64\MediaInfo.exe'

$mediaFile = 'C:\Temp\TestMedia\Justin Bieber - Beauty And A Beat (feat. Nicki Minaj).mp4'

# & $mediaInfoCliExe $mediaFile
$output = (& $mediaInfoCliExe $mediaFile)
# $properties = New-Object -TypeName System.Collections.ArrayList
$properties = [Ordered]@{}
[String]$currentProp = $null
foreach ($line in $output)
{
    # Check if blank 'separator' line
    if ($line -eq '')
    {
        # do notihng; ignore line
    }
    else 
    {
        # Check if group name or property/value pair
        if ($line -match '^(.+) +: (.+)$')
        {
            # Property/value pair found
            $propName = $matches[1].Trim()
            $propVal = $matches[2]
            (Get-Variable -Name $currentProp).Value.Add($propName, $propVal)
            # Write-Output "Prop: '$propName'; Val: '$propVal'"
        }
        else 
        {
            # Property group name found
            $currentProp = "var$line"
            New-Variable -Name $currentProp -Value ([Ordered]@{})
            $properties.Add($line, (Get-Variable -Name $currentProp).Value)
            # Write-Output "Group: '$line'"
        }
    }
}
$outputObj = New-Object -TypeName PSObject -Property $properties

Write-Output -InputObject $outputObj