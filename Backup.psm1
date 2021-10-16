function Backup-PS {

Process{

function Power-Copy {
Get-ChildItem -Path $startPath $modify -Recurse | ForEach-Object {
    $copy = Join-Path -Path $copyPath -ChildPath $_.FullName.Substring($startPath.Length)
    $original = Join-Path -Path $startPath -ChildPath $_.FullName.Substring($startPath.Length)
    If (Test-Path $copy) {
        $item = Get-Item -Path $copy
        $originalItem = Get-Item -Path $original
        If ($item.LastWriteTime -lt $originalItem.LastWriteTime) {
            Write-Warning "Updating: $_"
            Copy-Item -Path $original -Destination $copy
        }
    }
    ElseIf (-not (Test-Path $copy)) {
        Write-Warning "New Item: $_"
        Copy-Item -Path $original -Destination $copy
    }
}
}

#Backup PowerShell Logs and Modules
Write-Host "Copying PowerShell backup..."
$startPath = <PATH HERE>
$copyPath = <PATH HERE>
$modify = ""
Power-Copy


#Backup Batch Scripts
Write-Host "Copying Batch scripts backup..."
$startPath = <PATH HERE>
$copyPath = <PATH HERE>
$modify = "-include *.bat"
Power-Copy


#Backup Pictures
Write-Host "Copying pictures backup..."
$startPath = <PATH HERE>
$copyPath = <PATH HERE>
$modify = ""
Power-Copy


#Backup Documents
Write-Host "Copying documents backup..."
$startPath = <PATH HERE>
$copyPath = <PATH HERE>
$modify = ""
Get-ChildItem -Path $startPath -exclude "My Music","WindowsPowerShell" | Get-ChildItem -Recurse | ForEach-Object {
$copy = Join-Path -Path $copyPath -ChildPath $_.FullName.Substring($startPath.Length)
$original = Join-Path -Path $startPath -ChildPath $_.FullName.Substring($startPath.Length)
If (Test-Path $copy) {
        $item = Get-Item -Path $copy
        $originalItem = Get-Item -Path $original
        If ($item.LastWriteTime -lt $originalItem.LastWriteTime) {
            Write-Warning "Updating: $_"
            Copy-Item -Path $original -Destination $copy
        }
    }
    ElseIf (-not (Test-Path $copy)) {
        Write-Warning "New Item: $_"
        Copy-Item -Path $original -Destination $copy
    }
}



#Clean up old PowerShell Logs
Write-Host "Removing Old PowerShell Logs..."
$Path = <PATH HERE>
$Daysback = "-60"
$CurrentDate = Get-Date
$DeleteDate = $CurrentDate.AddDays($Daysback)
Get-ChildItem $Path | Where-Object { $_.LastWriteTime -lt $DeleteDate } | Remove-Item

}}
