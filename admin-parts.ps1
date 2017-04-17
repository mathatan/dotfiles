try
{
    # Do your script's stuff
    # Get the ID and security principal of the current user account
    $myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
     
    # Get the security principal for the Administrator role
    $adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

    # Check to see if we are currently running "as Administrator"
    if ($myWindowsPrincipal.IsInRole($adminRole))
       {
       # We are running "as Administrator" - so change the title and background color to indicate this
       $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
       $Host.UI.RawUI.BackgroundColor = "Black"
       clear-host
       }
    else
       {
       # We are not running "as Administrator" - so relaunch as administrator
       
       # Create a new process object that starts PowerShell
       $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
       
       # Specify the current script path and name as a parameter
       $newProcess.Arguments = '-ExecutionPolicy RemoteSigned -File "' +
                            $script:MyInvocation.MyCommand.Path + '"'
       
       # Indicate that the process should be elevated
       $newProcess.Verb = "runas";

       # Start the new process
       [System.Diagnostics.Process]::Start($newProcess);
       
       # Exit from the current, unelevated, process
       exit

       }
     
    # Run your code that needs to be elevated here
    Write-Host "Administrator password needs to be set for the installation to continue..."
    net user administrator /active:yes
    net user administrator *
    #iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    #choco install -y ag ctags curl editorconfig.core git.install hub lua vim-tux vcredist140 cygwin cyg-get conemu 7zip.install virtualbox vagrant mariadb
    #Invoke-WebRequest http://joedf.ahkscript.org/LuaBuilds/hdata/lua-5.3.4_Win64_bin.zip -OutFile lua.zip
    #$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    #7z x lua.zip -o"C:\Program Files\vim"

    Read-Host -Prompt "Install complete. Press any key."
}
catch
{
    Write-Error $_.Exception.ToString()
    Read-Host -Prompt "The above error occurred. Press Enter to exit."
}
