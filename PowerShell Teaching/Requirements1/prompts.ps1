# Nick Endrikat ID: 001170870

# Parameters
# Sets the Directory Variable as current directory
$directory = ".\"

# Functions

# Precedes current date/time before listing .log files
# Then gets files that end in .log and formats them into a table with file names
# finally the script appends those files' contents to Dailylog.txt then 
# returns to Get-Script function
function Write-Dailylog($directory)
{  try
   {
   Get-Date
   Get-ChildItem -Name *.log | Format-Table
   $files = Get-ChildItem -Name *.log
   Get-Date >> Dailylog.txt
   Get-Content $files >> DailyLog.txt
   Get-Scripts
   }
   catch [System.OutOfMemoryException]
   {
      "System out of Memory..."
   }
}

# This Function get the files in the directory variable and sorts them alphabetically from
# 0-9, A-Z aka: Ascending then returns to Get-Scripts function
function Get-Files($directory)
{  try
   {
   $files = Get-ChildItem | Sort-Object -Property Name | Format-Table
   $files
   $files > C916contents.txt
   Get-Scripts
   }
   catch [System.OutOfMemoryException]
   {
      "System out of Memory..."
   }
}

# This Functons gets the current usage of CPU and Memory at 5 second intervals
# Stopping at 4 samples then returns to Get-Scripts function
function Get-Usage()
{  try
   {
   Get-Counter -Counter "\Processor(_Total)\% Processor Time",`
   "\memory\% committed bytes in use" -SampleInterval 5 -MaxSamples 4
   Get-Scripts
   }
   catch [System.OutOfMemoryException]
   {
      "System out of Memory..."
   }
}
function Get-Current_Process()
{  try
   {
   Get-Process | Sort-Object -Property CPU -Descending | Out-GridView
   Get-Scripts
   }
   catch [System.OutOfMemoryException]
   {
      "System out of Memory..."
   }
}

# Function to select script using $choice variable attained from Read-Host
# When entering a number the switch statement
# Will select the proper function based on choice, 5 or any number other than 1-4 
# Will Exit script
function Get-Scripts
{  try
   {
   $choice = Read-Host "Enter choice 1-4, 5 to exit script: "
   switch ($choice) 
{
   1 {Write-Dailylog}
   2 {Get-Files}
   3 {Get-Usage}
   4 {Get-Current_Process}
   5 {"Exiting Script...";break}

}
   }
   catch [System.OutOfMemoryException]
   {
      "System out of Memory..."
   }
}

# Main Processing

Get-Scripts

