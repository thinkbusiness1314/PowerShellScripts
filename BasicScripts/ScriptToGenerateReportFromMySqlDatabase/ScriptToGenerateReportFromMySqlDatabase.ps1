#below line is needed to establish the connection with database
#This string is specfic to database and below line is for mysql database
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")

#below are the database details
$query = "select * from Student"

$databaseServer = "localhost"
$databaseName = "studentdb01"
$port = 3306
$username = "username"
$password = "username"

#creating a database connection object
$connection = New-Object MySql.Data.MySqlClient.MySqlConnection 
$connection.ConnectionString = "Server = $databaseServer; port = 3306; Database = $databaseName; Uid = $username; Pwd = $password; SslMode=None"  
$connection.Open()

#creating a command to connect with database kind of prepared query in java
$cmd = New-Object MySql.Data.MySqlClient.MySqlCommand
$cmd.Connection = $connection
$cmd.commandText = $query

#Creating datatable and loading the Query output into datatable
$myReader = $cmd.ExecuteReader()
$dataTable = New-Object System.Data.DataTable
$dataTable.Load($myReader)


#Preparing csv report with data
$reportLocation = "E:\PowerShellScripts\BasicScripts\ScriptToGenerateReportFromDatabase"
$reportString = (Get-Date -UFormat %Y%m%d%H%M%S) 
$dataTable | Export-Csv -NoTypeInformation -path $reportLocation\CsvReport$reportString".csv"


