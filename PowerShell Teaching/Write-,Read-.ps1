Write-Host "Hello World"

function Receive-Output {
   process {write-host $_ -ForegroundColor Green}

}

Write-Output "Testing using Write-Output" | Receive-Output
Write-Host "This is a test using write-host" | Receive-Output
Write-Output "Test test test" | Receive-Output

Write-Warning "THIS IS A WARNING"

Write-Error "THIS IS AN ERROR"

$name = "Nick"

Write-Output "Hello $name"
Write-Output 'Hello $name'
Write-Output "Hello `t `t $name"

$name = Read-Host "Who are you?"
$pass = Read-Host "What's your password?" -AsSecureString



