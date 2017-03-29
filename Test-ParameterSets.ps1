[CmdletBinding(DefaultParameterSetName = 'AllPrereqs')]
Param(
    [Parameter(ParameterSetName = 'IndividualPrereqs')]
    [Switch]$WindowsFeatures,
    [Parameter(ParameterSetName = 'IndividualPrereqs')]
    [Switch]$Net4,
    [Parameter(ParameterSetName = 'IndividualPrereqs')]
    [Switch]$UCMA,
    [Parameter(ParameterSetName = 'AllPrereqs')]
    [Switch]$All
)


$PSCmdlet.ParameterSetName

"features: $WindowsFeatures"
"net: $Net4"
"ucma: $UCMA"
"all: $All"