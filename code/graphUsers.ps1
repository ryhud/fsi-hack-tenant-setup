#install MSGraph module

#Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force

#Connect to ms graph using Global Admin (replace tenant ID)
#Connect-MgGraph -Scopes "User.ReadWrite.All,UserAuthenticationMethod.ReadWrite.All" -tenantid "Enter tenant ID"

#Update CSV with UPN suffix in your userPrincipalNames. e.g. user1@MngEnv814047.onmicrosoft.com etc

#Create team Users
$users = Import-Csv .\UserCreateTemplate.csv

ForEach ($user in $users) {

    $Password = @{
    Password = $user.passwordProfile    
  }

$mailNickName = $user.GivenName + $user.Surname 

New-MgUser -DisplayName $user.DisplayName -PasswordProfile $Password -AccountEnabled -UserPrincipalName $user.UserPrincipalName -GivenName $user.GivenName -Surname $user.Surname -MailNickname $mailNickName

}


