$ListFile = Read-Host -Prompt "Enter Rename CSV File:"
$destDir = Read-Host -Prompt "Enter Target Folder:"

#$ListFile = "C:\Users\mhous\OneDrive\Scripts\RenameTest.csv"
#$destDir = "C:\Users\mhous\OneDrive\Scripts\TestFolder"

$ListFile = $ListFile -replace '"',''
$destDir = $destDir -replace '"',''

#write-host $ListFile
#write-host $destDir


cd $destDir

$fileList = Get-ChildItem -Attributes !Directory -Recurse
$List = Import-Csv $ListFile

$missedFile = New-Object System.Collections.Generic.List[System.Object]
$missingFile = New-Object System.Collections.Generic.List[System.Object]
$existingFile = New-Object System.Collections.Generic.List[System.Object]

write-host "---Existing Files---"

foreach ($Listx in $List) {
    $old = $listx.old
    $new = $listx.new

    $old = $old -replace '[(]','[(]'
    $old = $old -replace '[)]','[)]'

    #write-host $old

    $file = Get-ChildItem "$old*" -Name -Recurse

     $ErrorLast = $Error[0]
    
    Get-ChildItem "$old*" -Recurse | Rename-Item -NewName { $_.Name -Replace $old , $new}
    If ($ErrorLast -ne $Error[0]) 
            {
        $ErrorWrite = "null"
        $ErrorWrite = ("-----------------" , $(Get-Date) , $Error[0].Exception , $Error[0].TargetObject)
        Write-host ("New Error" , $ErrorWrite)
        ##Out-File -FilePath C:\Users\mhous\OneDrive\Shows\MeanGirls\Scripts\log.txt" $ErrorWrite
        Out-File -FilePath log.txt -Append -InputObject $ErrorWrite
        }
   # Else {Write-host "Same Error, Ignore" $ErrorLast}
    
    
    #Out-File -FilePath log.txt -Append -InputObject "************************************************************"

    if ($file -ne $null) {

        write-host $file -ForegroundColor Green
        $existingFile.add($file)

    } 
    else {$missingFile.add($listx.old)} 
    

}

foreach ($file in $fileList.Name) {

    if (!($existingFile.contains($file))) {

        $missedFile.add($file)

    }

}

Write-Host "---Missed Files---"

foreach ($file in $missedFile) {

    write-host $file -ForegroundColor Red

}

Write-Host "---Missing Files---"

foreach ($file in $missingFile) {

    write-host $file -ForegroundColor magenta

}

#dir -Name

Read-Host
