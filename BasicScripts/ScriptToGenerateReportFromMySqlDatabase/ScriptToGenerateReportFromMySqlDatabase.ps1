#below line is needed to establish the connection with database
#This string is specfic to database and below line is for mysql database
[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")

$accNumber = read-host "Enter Account Number"

#below are the database details
$lhsQuery = "select * from Student $accNumber"
$rhsQuery = "select * from Student $accNumber"
$reportLocation = "E:\PowerShellScripts\BasicScripts\ScriptToGenerateReportFromDatabase"


#database Variables
$databaseServer = "localhost"
$databaseName = "studentdb01"
$port = 3306
$username = "username"
$password = "password"

#creating a database connection object
$connection = New-Object MySql.Data.MySqlClient.MySqlConnection 
$connection.ConnectionString = "Server = $databaseServer; port = 3306; Database = $databaseName; Uid = $username; Pwd = $password; SslMode=None"  
$connection.Open()

#Extract Data from lhs Table
#creating a command to connect with database kind of prepared query in java
$cmd1 = New-Object MySql.Data.MySqlClient.MySqlCommand
$cmd1.Connection = $connection
$cmd1.commandText = $lhsQuery

#Creating datatable and loading the Query output into datatable
$myReader = $cmd1.ExecuteReader()
$dataTable = New-Object System.Data.DataTable
$dataTable.Load($myReader)


#Preparing csv report with data
$reportString = (Get-Date -UFormat %Y%m%d%H%M%S) 
$dataTable | Export-Csv -NoTypeInformation -path $reportLocation\CsvReport_LHS_$reportString".csv"

#creating a command to connect with database kind of prepared query in java
$cmd2 = New-Object MySql.Data.MySqlClient.MySqlCommand
$cmd2.Connection = $connection
$cmd2.commandText = $rhsQuery

#Creating datatable and loading the Query output into datatable
$myReader = $cmd2.ExecuteReader()
$dataTable = New-Object System.Data.DataTable
$dataTable.Load($myReader)


#Preparing csv report with data
$reportString = (Get-Date -UFormat %Y%m%d%H%M%S) 
$dataTable | Export-Csv -NoTypeInformation -path $reportLocation\CsvReport_RHS_$reportString".csv"



$connection.Close()