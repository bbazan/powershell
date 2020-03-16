#Author Brandon Bazan http://ifitisnotbroken.wordpress.com/ 2020

Write-Host -ForegroundColor Yellow "Assembling a list of hosts to suppress warnings against"
$hosts = Get-VMHost
#ForEach loop that gets the current state of the alarm and updates to suppress the alarm
#Future feature will be to add in a menu allowing you to state the alarm "UserVars" and value
ForEach($alarmhost in $hosts){
    Write-host -ForegroundColor Green "UserVars.SuppressHyperthreadWarning is being supressed on $host"
    #Changing the value of this UserVars to 1 which suppresses the alarm, adding "Confirm:$false" which does not prompt the user to confirm the alarm suppression
    Get-AdvancedSetting -Entity $alarmhost -Name UserVars.SuppressHyperthreadWarning | Set-AdvancedSetting -Value 1 -Confirm:$false -Verbose

    #Writing the final status of changed alarms
    $UpdatedValue = Get-AdvancedSetting -Entity $alarmhost -Name UserVars.SuppressHyperthreadWarning
    Write-Host -ForegroundColor Yellow " `n ************************************************************* `n"
    Write-Host -ForegroundColor Green "Updated Values 1 = Suppressed, 0 = Active Alarm `n"
    Write-Host -ForegroundColor Green " ---- $updatedvalue ---- `n"
    Write-Host -ForegroundColor Yellow " `n ************************************************************* `n"
}