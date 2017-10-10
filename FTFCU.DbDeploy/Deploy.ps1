 #THis variables are just to test the powershell script they are not valid user name or password in any enviroment other than the dev machine.
$dbName ="Mask";
$dbUser ="Deployment";
$dbPassword ="Metro123$";
# Set params https://kwilson.io/blog/deploy-a-database-project-dacpac-using-octopusdeploy-and-powershell/
if (! $dbName)
{
    Write-Host "Missing required variable dbName" -ForegroundColor Yellow
    exit 1
}
if (! $dbUser)
{
    Write-Host "Missing required variable dbUser" -ForegroundColor Yellow
    exit 1
}
if (! $dbPassword)
{
    Write-Host "Missing required variable dbPassword" -ForegroundColor Yellow
    exit 1
}

# Add the DLL
# For 64-bit machines
$SqlServerDirectory ='Microsoft SQL Server\140\DAC\BIN'
Add-Type -path "${Env:ProgramFiles(x86)}/${SqlServerDirectory}/Microsoft.SqlServer.Dac.dll"
 write 'i am pass here'
# Create the connection string
$d = New-Object Microsoft.SqlServer.Dac.DacServices ("data source=.;User Id = " + $dbUser + ";pwd=" + $dbPassword)
 
#Load the dacpac
$dacpac = (Get-Location).Path + "\FTFCU.MaskDatabase.dacpac"
$dacpacoptions = (Get-Location).Path  + "\publish.xml"
 
Write-Host $dacpac
Write-Host $dacpacoptions
# #Load dacpac from file & deploy to database
$dp = [Microsoft.SqlServer.Dac.DacPackage]::Load($dacpac)
$dp
$dacProfile = [Microsoft.SqlServer.Dac.DacProfile]::Load($dacpacoptions)
## Deploy the dacpac
#$d.Deploy($dp, $dbName, $true, $dacProfile.DeployOptions)