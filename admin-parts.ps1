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
    # Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    choco install -y ag ctags curl editorconfig.core git.install hub lua vim-tux vcredist140 wsl 7zip.install 
    # cygwin cyg-get conemu virtualbox vagrant mariadb
    # TODO: Add parsing of url from http://joedf.ahkscript.org/LuaBuilds/
    Invoke-WebRequest http://joedf.ahkscript.org/LuaBuilds/hdata/lua-5.3.5_Win64_bin.zip -OutFile lua.zip
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
    7z x lua.zip -o"C:\Program Files\vim"

    Write-Host "Windows Subsystem for Linux is installed, but to install Ubuntu or any other system a reboot is required. This is not automated."
    Write-Host "To install Ubuntu run (as an administrator): choco install wsl-ubuntu-1804"
    Read-Host -Prompt "Install complete. Press any key."
}
catch
{
    Write-Error $_.Exception.ToString()
    Read-Host -Prompt "The above error occurred. Press Enter to exit."
}
