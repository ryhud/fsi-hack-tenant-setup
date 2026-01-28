# fsi-hack-tenant-setup

This repository includes artifacts that are to be used to load some users into a an Entra ID tenant that is applicable only to a private hackathon.

### Prerequisites
* A new MCAPS subscription configured with an external tenant with Global Admin Credentials.
* A Windows Desktop for interactive login (Device login is bloced for MCAPS environment).
* [PowerShell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.5) Installed
* Latest MS Graph [PowerShell SDK](https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation). Verify Installation first. If installed, upgrade. If not installed, Install the module. All instructions in the link.
* Git for Windows if you want to clone this repository.

### Resources Deployed
6 users get deployed into the tenant along with the configuration for a Temporary Access Pass to configure MFA (MS Authenticator app).


### Modify the Users CSV

    * Open up the UserCreateTemplate.csv and replace the UPN suffixes of the userPrincipalName values with the domain name of your tenant (e.g mydomain.onmicrosoft.com).
    * (Optional) - create your own passwordProfile values (password change will be forced anyway).

### Provisioning the users

1. Launch PowerShell.
2. Clone this repo.

    ```powershell
    git clone https://github.com/ryhud/fsi-hack-tenant-setup.git
    ```
3.  Authenticate to MS Graph (add your own tenant ID).

    ```powershell
    Connect-MgGraph -Scopes "User.ReadWrite.All,UserAuthenticationMethod.ReadWrite.All" -tenantid "Enter tenant ID"
    ```
    When prompted, sign in with your global admin credentials and accept the permissions when prompted. 
    
 
4. Navigate to the scripts folder .

    ```powershell
    cd code
    ```
5. Create the users.
    ```powershell
    .\graphUsers.ps1
    ```
6. Wait at least 1 minute and then configure the Temporary Access Passes.
    ```powershell
    .\graphTap.ps1
    ```
    Your output should look like the following:

    ![image](/images/tap_output.jpg)

    Copy the output as we will need it for the next step. 

7. Allocate each team member to a user account and provde them the userPrincipalName and Password from the CSV file along the Temporary Access Pass generated earlier. 

### Have each hack team member finish setting up their user accounts. 

NOTE: The order of these steps is very important to properly set up the account. 

1. Open up a new InPrivate window and Sign into https://aka.ms/mysecurityinfo. Enter the username and Temporary Access Pass.

    ![image](/images/signinWithTap.jpg)

2. Select Security Info on the left pane and then "+ Add sign-in method". Configure "Microsoft Authenticator".

   ![image](/images/securityInfo.jpg)

3. After successful MFA setup, check to see if the Temporary Access Pass still exists. If it does, delete it.

    ![image](/images/deleteTap.jpg)

4. Sign out from the page. 

    ![image](/images/signOut.jpg)

5. Sign back into https://aka.ms/mysecurityinfo. This time you will be prompted for your password (not the one time access pass) and MFA. After successfull sign in, you will be prompted to change your password. 

### Configure RBAC to the Azure Subscription
1. After each hack team member has set up their accounts, Create a new Entra ID Group and add each team member to the group. 
2. Add the group as an owner to the Azure Subscription. 
3. Verify each team member can access the subscription. 

### Next Steps
1. contact one of your hack coaches and have them verify that everything is setup correctly. 
