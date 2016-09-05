#Import Modules
Import-Module sqlpsx -DisableNameChecking

$BaseDirectory = 'C:\canvas_integration\data_files\'
$SQLServer = "ENTER SQLSERVER NAME HERE"
$SQLDB = "ENTER SQL DATABASE NAME HERE"

$sourceDir = "C:\canvas_integration\data_files\" #this is source directory literal path
$outputPath = "C:\canvas_integration\" #output path for the zip file creation
$account_id = "1" #root account id from Canvas, usually 1
$token = "" # access_token
$domain = "haileybury.instructure.com" #hthis is your Canvas url
$outputZip = "canvas_data.zip" # name of the zip file to create
$diff_id = "2016semester1" #create a unique ID to use diffing, this is what subsequent sis import will compare data against to speed up imports
$diff_remaster = "false" # set to true if you need to push a remaster into Canvas, else leave false.

##Run the snapshots to extract the data to CSV's ##
ExportSQLtoCSV 'users' 'uvCanvasUsers'
ExportSQLtoCSV 'accounts' 'uvCanvasAccounts'
ExportSQLtoCSV 'terms' 'uvCanvasTerms'
ExportSQLtoCSV 'courses' 'uvCanvasCourseImport'
ExportSQLtoCSV 'sections' 'uvCanvasSections'
ExportSQLtoCSV 'enrollments' 'uvCanvasEnrolments'
ExportSQLtoCSV 'groups' 'uvCanvasGroups'
ExportSQLtoCSV 'groups_membership' 'uvCanvasGroupsMembership'
#ExportSQLtoCSV 'xlists' 'uvCanvasXlists'
ExportSQLtoCSV 'user_observers' 'uvCanvasObservers'

#Set the working Directory
cd $BaseDirectory

Function ExportSQLtoCSV{
  param($outputFile,$viewName)
  
  $outputFileLocation = "$($BaseDirectory)$($outputFile).csv" 
  $SQLQuery = "SELECT DISTINCT * FROM [SynergyOne].[dbo].[" + $viewName + "]"
  Get-SqlData -sqlserver $SQLServer -dbname $SQLDB -qry $SQLQuery | Export-Csv -NoTypeInformation $outputFileLocation
  Write $outputFile
}


## Convert each CSV to UTF8 Format ##
foreach($i in ls -name "$BaseDirectory\*.csv")
{
    $file = get-content "$BaseDirectory\$i"
    $encoding = New-Object System.Text.UTF8Encoding($False)
    [System.IO.File]::WriteAllLines("$BaseDirectory\$i", $file, $encoding)
}

######################################################
##													##
##  Create zip file containing our exported files  ##
##													##
######################################################

# Just in case $sourceDir doesn't end with a \, add it.
if(!($sourceDir.EndsWith('\'))){
    $sourceDir += "\"
    Write-Host "You sourceDir didn't end with a \ so I added one.  It really is important"
}
if($outputZip.Contains('\')){
    Write-Host "The outputZip should not contain backslashes.  You are warned"
}

###### Some functions

$contentType = "application/zip" # don't change
$InFile = $outputPath+$outputZip # don't change
write-zip -Path $sourceDir"*.csv" -OutputPath $InFile

$t = get-date -format M_d_y_h
$status_log_path = $outputPath+$t+"-status.log"


#################################################
###### Don't edit anything after this line ######
#################################################
$url = "https://$domain/api/v1/accounts/"+$account_id+"/sis_imports.json?import_type=instructure_csv&diffing_data_set_identifier=$diff_id&diffing_remaster_data_set=$diff_remaster"
$headers = @{"Authorization"="Bearer "+$token}

# Just in case $sourceDir doesn't end with a \, add it.
if(!($sourceDir.EndsWith('\'))){
    $sourceDir += "\"
    Write-Host "You sourceDir didn't end with a \ so I added one.  It really is important"
}
if($outputZip.Contains('\')){
    Write-Host "The outputZip should not contain backslashes.  You are warned"
}

###### Some functions
$contentType = "application/zip" # don't change
$InFile = $outputPath+$outputZip # don't change
write-zip -Path $sourceDir"*.csv" -OutputPath $InFile

$t = get-date -format M_d_y_h
$status_log_path = $outputPath+$t+"-status.log"
#Write-Host "infile:"$InFile
#Write-Host "contentType:"$contentType
#$results = invoke-RestMethod -Headers $headers -InFile $InFile -Method POST  -ContentType $contentType -uri $url -PassThru -OutFile $outputPath$t"-status.log"

$results1 = (Invoke-WebRequest -Headers $headers -InFile $InFile -Method POST -ContentType $contentType -Uri $url) #-PassThru -OutFile $outputPath$t"-status.log"
$results1.Content | Out-File $status_log_path
$results = ($results1.Content | ConvertFrom-Json)
#$results.id | Out-String
do{
  Write-Host $status_line
  $status_url = "https://$domain/api/v1/accounts/"+$account_id+"/sis_imports/"+$results.id
  $results1 = (Invoke-WebRequest -Headers $headers -Method GET -Uri $status_url) #-PassThru -OutFile $outputPath$t"-status.log"
  $results1.Content | Out-File -Append $status_log_path
  $results = ($results1.Content | ConvertFrom-Json)
  Start-Sleep -s 5
  #$results.id | Out-String
 if($results -eq $null){
    break
  }
}
while($results.progress -lt 100 -and $results.workflow_state -ne "failed_with_messages")
$results1.Content | Out-File -Append $status_log_path

# The sis import is done, you might do something else here like trigger course copies

Move-Item -Force $outputPath$outputZip $outputPath$t-$outputZip
Remove-Item $sourceDir*.csv
