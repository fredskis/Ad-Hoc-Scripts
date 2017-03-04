# Ad-Hoc-Scripts  
Miscellaneous generally single-purpose scripts

## Rename-MoviesRadarr.ps1  
Initially created for personal use.  
Prepares target movie folder for compatibility with [Radarr](https://radarr.video). 
Using current movie file nammes, creates new folders for each movie at the root folder and one subfolder in based on the movie file name.  
Option for running script in Verbose mode without making any changes to confirm changes first.  
  
The only commands the script uses for editing the file system are:  
* Creating new movie directory at root  
* Move movie file to above directory  
* Delete old directory if it was processed (collection folders)

Errors won't stop the script but will be visible so you can manually fix them at the end. Possible errors are read-only files or illegal file names (e.g. movie name ending in a space character).  

### Running script  
Use this first to see what the script will do without making changes:  
`Rename-MoviesRadarr.ps1 -Path 'C:\PathToMovieRootFolder' -Verbose`  
YOLO mode to rename movies with no Verbose output (Verbose always recommended)  
`Rename-MoviesRadarr.ps1 -Path 'C:\PathToMovieRootFolder' -DoWork`  

### Assumptions  
* There are ONLY movie files in the Movies folder (i.e. no subs, samples, extras etc)  
* Movies are only nested one level deep inside a collection  
* ALL movies are unsorted; if movies are already in proper target format the folders will get deleted  

See script for up-to-date assumptions