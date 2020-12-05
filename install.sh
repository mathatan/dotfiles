#!/bin/bash

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if [[ "$OSTYPE" == "darwin"* ]]; then
    sudo gem uninstall cocoapods cocoapods-core cocoapods-deintegrate cocoapods-downloader cocoapods-plugins cocoapods-search cocoapods-trunk cocoapods-try

    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    else
        brew update
    fi

    brew install zsh zsh-completions
    brew install rsync ctags the_silver_searcher rbenv ruby-build nvm #python nvm # node@6
    brew install imagemagick

    echo "gem: -n/usr/local/bin" > ~/.gemrc

    export RUBY_HOME=/usr/local/opt/ruby/bin
    export PATH=$RUBY_HOME:$PATH
    export RBENV_ROOT="$(brew --prefix rbenv)"
    export GEM_HOME="$(brew --prefix)/opt/gems"
    export GEM_PATH="$(brew --prefix)/opt/gems"

    gem update
    gem install cocoapods

    pod setup

    # needed by afsctool below
    brew install google-sparsehash zlib cmake pkgconfig

    #brew install macvim --custom-icons --with-override-system-vim --with-lua --with-luajit
    # brew install neovim

    # quick preview code formatting
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package --force
    #code
    brew cask install adoptopenjdk8 visual-studio-code android-studio sourcetree macvim xquartz flutter

    #audio and video
    brew cask install audio-hijack airfoil spotify iina vlc
    #tools
    brew cask install lastpass the-unarchiver adobe-creative-cloud google-chrome adguard tunnelblick
    #3d printing
    brew cask install ultimaker-cura autodesk-fusion360

    defaults write org.n8gray.QLColorCode font Inconsolata\ XL
    defaults write org.n8gray.QLColorCode hlTheme solarized-dark
    defaults write org.n8gray.QLColorCode extraHLFlags '-l -W -t=4'

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    nvm install 8 --lts

    export PKG_CONFIG_PATH=/usr/local/opt/zlib/lib/pkgconfig

    CURPATH=`pwd -P`

    cd ..

    # build afsctool / hfs compression
    git clone git://github.com/RJVB/afsctool
    mkdir afsctool/build
    cd afsctool/build
    cmake -Wno-dev ..
    make

    cd afsctool/build
    sudo make install/fast V=1 VERBOSE=1

    cd $CURPATH

elif [[ !`grep -q Microsoft /proc/version` ]]; then
    # wsl linux
    sudo apt-get install -y zsh
    sudo apt-get install -y ctags silversearcher-ag curl software-properties-common
    sudo apt-get install -y python-dev python-pip python3-dev python3-pip
    # sudo apt-get install -y mercurial

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

cp $CURDIR/zsh.after/env.zsh ~/.zsh.after/.

# touch ~/.zsh.after/env

if [[ "$OSTYPE" == "darwin"* ]]; then
    vim +PluginInstall +qall
    #nvim +PlugInstall +qall
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

echo "Restart your shell and run respective updates to e.g. gem, npm, pod setup etc."
