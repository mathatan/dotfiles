#!/bin/bash

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh zsh-completions
    brew install rsync ctags the_silver_searcher python nvm # node@6
    brew install imagemagick
    #brew install macvim --custom-icons --with-override-system-vim --with-lua --with-luajit

    brew install neovim
    brew cask install vimr tortoisehg xquartz fontforge
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package --force

    defaults write org.n8gray.QLColorCode font Inconsolata\ XL
    defaults write org.n8gray.QLColorCode hlTheme solarized-dark
    defaults write org.n8gray.QLColorCode extraHLFlags '-l -W -t=4'

    brew install macvim

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    nvm install 8 --lts
elif [[ !`grep -q Microsoft /proc/version` ]]; then
    # wsl linux
    sudo apt-get install -y zsh
    sudo apt-get install -y ctags silversearcher-ag curl software-properties-common
    sudo apt-get install -y python-dev python-pip python3-dev python3-pip
    sudo apt-get install -y mercurial

    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo apt-get update
    sudo apt-get -y install neovim

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor

    sudo apt-get install -y build-essential libssl-dev

    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm install --lts
else 
    echo "Unsuported platform..."
    exit 1;
fi

npm install -g csslint eslint prettier prettier-eslint prettier-eslint-cli eslint-config-prettier eslint-plugin-html eslint-plugin-prettier eslint-plugin-react eslint-plugin-requirejs htmlhint babel-eslint js-beautify jsonlint

CURDIR=`pwd -P`

ln -s $CURDIR/_vimrc ~/.vimrc
ln -s $CURDIR/vim ~/.vim

if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.after;
fi

ln -s $CURDIR/bin ~/.dotfilesbin
ln -s $CURDIR/vimify/inputrc ~/.inputrc
ln -s $CURDIR/vimify/editrc ~/.editrc
ln -s $CURDIR/ctags/ctags ~/.ctags
ln -s $CURDIR/zsh/prezto/runcoms/zshenv ~/.zshenv
ln -s $CURDIR/zsh/prezto/runcoms/zlogin ~/.zlogin
ln -s $CURDIR/zsh/prezto/runcoms/zlogout ~/.zlogout
ln -s $CURDIR/zsh/prezto ~/.zprezto
ln -s $CURDIR/zsh/prezto-override/zshrc ~/.zshrc
ln -s $CURDIR/zsh/prezto-override/zpreztorc ~/.zpreztorc
ln -s $CURDIR/zsh/prezto-override/zprofile ~/.zprofile
ln -s $CURDIR/zsh ~/.zsh

mkdir -p ~/.zsh.before
mkdir -p ~/.zsh.after
mkdir -p ~/.zsh.prompts

touch ~/.zsh.after/env

if [[ "$OSTYPE" == "darwin"* ]]; then
    vim +PluginInstall +qall
    nvim +PlugInstall +qall
fi

# If this user's login shell is not already "zsh", attempt to switch.
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
        printf "Time to change your default shell to zsh!\n"
        chsh -s $(grep /zsh$ /etc/shells | tail -1)
        # Else, suggest the user do so manually.
    else
        printf "I can't change your shell automatically because this system does not have chsh.\n"
        printf "Please manually change your default shell to zsh!\n"
    fi
fi
