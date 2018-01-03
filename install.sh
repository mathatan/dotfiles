#!/bin/sh

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#brew install zsh zsh-completions

brew install rsync ctags the_silver_searcher python node@8
brew install macvim --custom-icons --with-override-system-vim --with-lua --with-luajit
npm install -g csslint prettier-eslint prettier-eslint-cli eslint-config-prettier eslint-plugin-html eslint-plugin-prettier eslint-plugin-react eslint-plugin-requirejs htmlhint babel-eslint js-beautify jsonlint

ln -s ${pwd}/_vimrc ~/.vimrc
ln -s ${pwd}/vim ~/.vim
