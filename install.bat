@echo off
:: To install 
:: $ powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/mathatan/dotfiles/master/install.bat -OutFile install.bat" && install.bat

powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest https://raw.githubusercontent.com/mathatan/dotfiles/master/admin-parts.ps1 -OutFile admin.ps1;.\admin.ps1"
echo Waiting for installation.
pause
:: Get System PATH
for /f "tokens=3*" %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set syspath=%%A%%B

:: Get User Path
for /f "tokens=3*" %%A in ('reg query "HKCU\Environment" /v Path') do set userpath=%%A%%B

:: Set Refreshed Path
set PATH=%path%;%userpath%;%syspath%

cd %USERPROFILE%
git --recurse-submodules -j8 clone https://github.com/mathatan/dotfiles.git
git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/dotfiles/vim/bundle/Vundle.vim
runas /user:administrator "cmd.exe /C cd %userprofile% & mklink /d .vim dotfiles\vim & mklink _vimrc dotfiles\_vimrc"
:: Figure out how to make fonts work
::powershell -Command "$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14); Get-ChildItem -Recurse -include dotfiles/fonts/*.ttf | % { $fonts.CopyHere($_.fullname) }"
cmd /c vim +PluginInstall +qall
cmd /c cyg-get.bat rsync-3.1.2-1 openssh-7.5p1-1 zsh-5.1.1-1

:: Cleanup...
del lua.zip
del admin.ps1
del install.bat
runas /user:administrator "net user administrator /active:no"
