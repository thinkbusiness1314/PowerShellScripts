#This is the path of the file to be processed
$filePath = "E:\PowerShellScripts\BasicScripts\ScriptToProcessPlainTextToCsv\Test.txt"
$destinationPath = "E:\PowerShellScripts\BasicScripts\ScriptToProcessPlainTextToCsv\"

#The below Array consist of line numbers which need to be removed from file
$linesArray = [Array] 2

#This parameter define the expected number of characters in each line. 
#If any Line cointains characters below this parameter will not be processed
$widthOfLine = 135

#Defining Columns
$column1 = [Column]::new()
$column1.startCharacter = 0
$column1.lengthOfColumn = 38


$column2 = [Column]::new()
$column2.startCharacter = 38
$column2.lengthOfColumn = 17


$column3 = [Column]::new()
$column3.startCharacter = 55
$column3.lengthOfColumn = 26

$column4 = [Column]::new()
$column4.startCharacter = 81
$column4.lengthOfColumn = 54

$columnList = [System.Collections.ArrayList]::new()
$columnList.Add($column1)
$columnList.Add($column2)
$columnList.Add($column3)
$columnList.add($column4)


#Check Whether file Existt in source location or not 
if(Test-Path -Path $filePath){

   $dataTable = New-Object System.data.DataTable 'TestDataTable'
   $newcol = New-Object system.Data.DataColumn Column1,([string]); $dataTable.columns.add($newcol)
   $newcol = New-Object system.Data.DataColumn Column2,([string]); $dataTable.columns.add($newcol)
   $newcol = New-Object system.Data.DataColumn Column3,([string]); $dataTable.columns.add($newcol)
   $newcol = New-Object system.Data.DataColumn Column4,([String]); $dataTable.columns.add($newcol)
   
  #Copying Data text file data into a ArrayList
  [System.Collections.ArrayList]$content = Get-Content -Path $filePath

  #ArrayList to store error lines whoose length is less than expected
  $errorLines = [System.Collections.ArrayList]::new()

   #Removing required Lines from afile
   for( $i = 0; $i -lt $linesArray.Length ;$i++ ){
        $content.RemoveAt(($linesArray[$i]-1))
   }



   #In this loop we are reading the file lines and breaking into colums then filling columns into data table
   for( $j = 0; $j -lt $content.Count; $j++ ){

      if($content[$j].length -ge $widthOfLine){
      
        $row = $dataTable.NewRow()

        $row.Column1 = $content[$j].SubString($columnList[0].startCharacter,$columnList[0].lengthOfColumn)
        $row.Column2 = $content[$j].SubString($columnList[1].startCharacter,$columnList[1].lengthOfColumn)
        $row.Column3 = $content[$j].SubString($columnList[2].startCharacter,$columnList[2].lengthOfColumn)
        $row.Column4 = $content[$j].SubString($columnList[3].startCharacter,$columnList[3].lengthOfColumn)

        $dataTable.Rows.add($row)

     }else{
        $errorLines.Add($content[$j])
     }
      
   }
   
   #The below String defines the Output file formats
   $reportString = (Get-Date -UFormat %Y%M%d%H%M%S) 
   $report = $destinationPath+"\TheFinalReport"+$reportString+".csv"
   $errors = $destinationPath+"\ErrorLines"+$reportString+".txt"
   
   $dataTable | Export-Csv -NoTypeInformation -Path $report  
   $errorLines | Out-File -FilePath $errors


}else{
    Write-Host "Source File Not Exist"
}


#The Class to store start and end characters while extracting columns from text line
#This implementation gives a flexibility do changes and to add or remove columns
Class Column{

    [int] $startCharacter
    [int] $lengthOfColumn

}


