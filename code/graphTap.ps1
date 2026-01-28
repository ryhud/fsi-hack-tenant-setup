#RUN GRAPH USERS FIRST

$users= Import-Csv .\UserCreateTemplate.csv

$tap = foreach ($user in $users) { 

    $tapProperties = @{}
    $tapProperties.isUsableOnce = $True
    $tapProperties.startDateTime = (Get-Date).ToUniversalTime()
    $tapPropertiesJSON = $tapProperties | ConvertTo-Json

    $mguserTap = New-MgUserAuthenticationTemporaryAccessPassMethod -UserId $user.userPrincipalName -BodyParameter $tapPropertiesJSON

    [pscustomobject]@{
        UserPrincipalName = $user.userPrincipalName
        TempAccessPass = $mgUserTAP.TemporaryAccessPass

    }
}
$tap |Select-Object UserPrincipalName, TempAccessPass
