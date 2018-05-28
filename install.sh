#!/bin/sh

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install zsh zsh-completions
brew install rsync ctags the_silver_searcher python node@6
brew install macvim --custom-icons --with-override-system-vim --with-lua --with-luajit
npm install -g csslint eslint prettier prettier-eslint prettier-eslint-cli eslint-config-prettier eslint-plugin-html eslint-plugin-prettier eslint-plugin-react eslint-plugin-requirejs htmlhint babel-eslint js-beautify jsonlint

CURDIR=`pwd`

ln -s $CURDIR/_vimrc ~/.vimrc
ln -s $CURDIR/vim ~/.vim

if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.after;
fi

ln -s $CURDIR/bin ~/.dotfilesbin
ln -s $CURDIR/vimify/inputrc ~/.inputrc
ln -s $CURDIR/vimify/editrc ~/.editrc
ln -s $CURDIR/ctags/ctags ~/.ctags
ln -s $CURDIR/zsh/prezto-override/zshrc ~/.zshrc
ln -s $CURDIR/zsh/prezto/runcoms/zshenv ~/.zshenv
ln -s $CURDIR/zsh/prezto/runcoms/zlogin ~/.zlogin
ln -s $CURDIR/zsh/prezto/runcoms/zlogout ~/.zlogout
ln -s $CURDIR/zsh/prezto/runcoms/zprofile ~/.zprofile
ln -s $CURDIR/zsh/prezto ~/.zprezto
ln -s $CURDIR/zsh/prezto-override/zpreztorc ~/.zpreztorc
ln -s $CURDIR/zsh ~/.zsh

mkdir -p ~/.zsh.before
mkdir -p ~/.zsh.after
mkdir -p ~/.zsh.prompts

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
