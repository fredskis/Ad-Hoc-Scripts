# ASSUMPTIONS:
# There are ONLY movie files in the Movies folder (i.e. no subs, samples, extras etc)
# Movies are only nested one level deep inside a collection
# ALL movies are unsorted; if movies are already in proper target format the folders will get deleted

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [String]$Path, 
    [Parameter()]
    [Switch]$DoWork
)
if (-not $DoWork) {
    Write-Warning -Message 'The DoWork switch parameter is not enabled, no actual work will take place'
}

Function New-MovieFilePath {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [IO.FileInfo]$MovieFile, 
        [Parameter()]
        [Switch]$DoWork
    )
    # Create target folder 
    $targetFolder = Join-Path -Path $Path -ChildPath $MovieFile.BaseName
    Write-Verbose -Message "Creating target folder '$targetFolder'"
    if ($DoWork) {
        New-Item -Path $targetFolder -ItemType Directory
    }
    # Move file to target folder 
    Write-Verbose -Message "Moving file '$($MovieFile.FullName)' to target folder"
    if ($DoWork) {
        Move-Item -Path $MovieFile.FullName -Destination $targetFolder #-Force # Unneeded as there won't be any overwriting
    }
}

$collections = Get-ChildItem -Path $Path -Directory
$movies = Get-ChildItem -Path $Path -File

# Iterate through collections and nested movies (assumes only one level below collection folders)
foreach ($collection in $collections) {
    Write-Verbose -Message "Processing collection '$($collection.Name)'"
    $collMovies = Get-ChildItem -Path $collection.FullName -File
    foreach ($movie in $collMovies) {
        New-MovieFilePath -MovieFile $movie -DoWork:$DoWork
    }
    if ($DoWork) {
        if ((Get-ChildItem -Path $collection.FullName).Count -eq 0) {
            Remove-Item -Path $collection.FullName #-Force # Unneeded as no read-only/hidden folders
        }
        else {
            Write-Error -Message "Collection '$($collection.Name)' is not empty" -Category InvalidData -ErrorAction Continue
        }
    }
}

# Iterate through movies in flat structure
foreach ($movie in $movies) {
    New-MovieFilePath -MovieFile $movie -DoWork:$DoWork
}
