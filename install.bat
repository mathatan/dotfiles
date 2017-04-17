@echo off
:: To install 
:: $ powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/mathatan/gVimRC/master/install.bat -OutFile install.bat" && install.bat

powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest https://raw.githubusercontent.com/mathatan/gVimRC/master/admin-parts.ps1 -OutFile admin.ps1;.\admin.ps1"
echo Waiting for installation.
pause
:: Get System PATH
for /f "tokens=3*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set syspath=%%A%%B

:: Get User Path
for /f "tokens=3*" %%A in ('reg query "HKCU\Environment" /v Path') do set userpath=%%A%%B

:: Set Refreshed Path
set PATH=%path%;%userpath%;%syspath%

cd %USERPROFILE%
git clone https://github.com/mathatan/gVimRC.git
git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/gVimRC/.vim/bundle/Vundle.vim
runas /user:administrator "cmd.exe /C cd %userprofile% & mklink /d .vim gVimRC\.vim & mklink _vimrc gVimRC\_vimrc"
:: Figure out how to make fonts work
::powershell -Command "$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14); Get-ChildItem -Recurse -include gVimRC/fonts/*.ttf | % { $fonts.CopyHere($_.fullname) }"
cmd /c vim +PluginInstall +qall
cmd /c cyg-get.bat rsync-3.1.2-1 openssh-7.5p1-1 zsh-5.1.1-1

:: Cleanup...
del lua.zip
del admin.ps
del install.bat
runas /user:administrator "net user administrator /active:no"
