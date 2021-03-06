Basic automated system setup for Windows and MacOs
==================================================

Based on [YADR](https://github.com/skwp/dotfiles) vim configuration.

Requires installation of [Chocolatey](https://chocolatey.org/) or something similar for easier configuration. There might be an installation script at some point, but for now this is only static files.

Installation
------------

```
$ powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/mathatan/dotfiles/master/install.bat -OutFile install.bat" && install.bat
```

With Linux or MacOs clone the repositories:
```
$ git clone --recurse-submodules -j8 https://github.com/mathatan/dotfiles.git
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
``` 

and run `$ install.sh` from the dot files folder.


### Fonts

To have gvim display all special characters correctly batch fonts should be installed from `fonts` directory.



Outdated parts
--------------

### Lua support
In addition to that you'll still need to copy Lua dll into vim installation directory in `C:\Program Files\vim`.

Download Lua dll e.g. from: http://joedf.ahkscript.org/LuaBuilds/


### Vundle

No Vundle is directly provided in the repo. It's required to first clone Vundle from https://github.com/VundleVim/Vundle.vim

```
$ cd %USERPROFILE%
$ git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/.vim/bundle/Vundle.vim
```

Now you should be ready install Vundle bundles. This should still be done within an elevated rights CMD or Shell.

```
vim -c VundleInstall -c quitall
```

### Make gvim open files in buffers

If you're like me and are used to vim buffers instead of tabs and want to only use one instance of gvim at any time, you'll need to do some registry editing.

In essence it's required to replace all `"...\gvim.exe" "%1"` mentions in the registry with `"...\gvim.exe" --remote-silent "%1"`


### Enjoy

That's it. You should now have a working gvim installation with all the bells and whistles. Enjoy and go be productive!
