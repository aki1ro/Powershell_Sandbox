# Nick Endrikat ID: 001170870

# Main Process

# This command creates a new OU called "finance"
try
{
New-ADOrganizationalUnit -Name finance
}
catch [System.OutOfMemoryException]
{
   "System is out of Memory..."
}
# This command creates users based off the financePersonnel.csv
$Users = Import-Csv .\financePersonnel.csv
foreach($User in $Users)
{  try
   {
   $Info = 
   @{
      Name = "$($User.First_Name) $($User.Last_Name)"
      DisplayName = "$($User.First_Name) $($User.Last_Name)"
      AccountPassword = (ConvertTo-SecureString 1qaz@WSX3edc$RFV -AsPlainText -Force)
		GivenName = $User.First_Name
		Surname = $User.Last_Name
      SamAccountName = $User.SamAccountName
      PostalCode = $User.PostalCode
      OfficePhone = $User.OfficePhone
      MobilePhone = $User.MobilePhone
		Path = "OU=finance,DC=ucertify,DC=com"
		Enabled = $true
   

   }
   New-ADuser @Info
   }
   catch [System.OutOfMemoryException]
   {
      "System is out of Memory..."
   }
}

# These commands create the Database "ClientDB"
try
{
Import-Module -Name sqlps -DisableNameChecking
$srv = New-Object Microsoft.SqlServer.Management.Smo.Server(".\UCERTIFY3")
$db = New-Object Microsoft.SqlServer.Management.Smo.Database($srv, "ClientDB")
$db.Create()
}
catch [System.OutOfMemoryException]
{
   "System is out of Memory..."
}

#This command runs the createtable.sql script to create a table called "Client_A_Contacts"
#This table will be created within the ClientDB database created by the prior commamnds
#This script is located within the same folder as the script aka: c:\requirements2
try
{
Invoke-Sqlcmd -ServerInstance .\UCERTIFY3 -Database ClientDB -InputFile C:\requirements2\createtable.sql
}
catch [System.OutOfMemoryException]
{
   "System is out of Memory..."
}

#This command takes the NewClientData.csv file and imports it into the Client_A_Contacts Table
try
{
Import-CSV C:\requirements2\NewClientData.csv | ForEach-Object {Invoke-Sqlcmd `
   -Database ClientDB -ServerInstance .\UCERTIFY3 `
   -Query "insert into dbo.Client_A_Contacts VALUES ('$($_.first_name)','$($_.last_name)','$($_.city)','$($_.county)','$($_.zip)','$($_.officePhone)','$($_.mobilePhone)')"
   }
}
catch [System.OutOfMemoryException]
{
   "System is out of Memory..."
}
