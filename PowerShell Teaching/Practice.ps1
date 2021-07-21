#  Parameters
#The script should take 2 arguments $source and $destination (for the source and destination folders).

param([string]$source = "C:\Requirements1", [string]$destination = "C:\")

#Functions

#Create a function named CheckFolder that checks for the existence of a specific directory/folder that is passed 
#to it as a parameter. Also, include a switch parameter named create. If the directory/folder does not exist and 
#the create switch is specified, a new folder should be created using the name of the folder/directory that was 
#passed to the function.
function Test-Folder([string]$path, [switch]$create){
   $exists = Test-Path $path

   if(!$exists -and $create){
      #create the directory because it doesn't exist
      mkdir $path
      Write-Host "($path) doesn't exist and was created"
      $exists = Test-Path $path
   }
   return $exists

}

#Create a function named DisplayFolderStatistics to display folder statistics for a directory/path that is passed 
#to it. Output should include the name of the folder, number of files in the folder, and total size of all files in 
#that directory.

function Show-FolderStats([string]$path){
   $files = Get-ChildItem $path -Recurse | Where-Object {!$_.PSIsContainer}
   $totals = $files | Measure-Object -Property length -sum
   $stats = "" | Select-Object path,count,size
   $stats.path = $path
   $stats.count = $totals.count
   $stats.size = [math]::round($totals.sum/1MB,2)
   return $stats
}

# Main processing <--- what's run during the script

#a) Test for existence of the source folder (using the CheckFolder function).
$sourceexists = Test-Folder $source

if(!$sourceexists){
   Write-Host "The source directory is not found. Script can't continue"
   Exit
}

#b) Test for the existence of the destination folder; create it if it is not found (using the CheckFolder function 
$destinationexists = Test-Folder $destination -create

#with the –create switch).Write-Host "Testing Destination Directory - $destination"
if(!$destinationexists){
   Write-Host "The destination directory is not found. Script can't continue"
   Exit
}

#c) Copy each file to the appropriate destination.
#get all the files that need to be copied
$files = Get-ChildItem $source -Recurse | Where-Object {!$_.PSIsContainer}

#c-i) Display a message when copying a file. The message should list where the file is being
foreach ($file in $files){
   $ext = $file.Extension.Replace(".","") # used to search for a specific extension
   $extdestdir = "$destinatio\$ext"
   $extdestdir

   #check to see if destination folder exists, if not create it
   $extdestdirexists = Test-Folder $extdestdir -create
   
   if(!$extdestdirexists){
      Write-Host "The destination directory ($extdestdir) can't be created"
      Exit
   }
   
   #copy file
   Copy-Item $file.fullname $extdestdir
}

#moved from and where it is being moved to.





#d) Display each target folder name with the file count and byte count for each folder.


