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
ln -s $CURDIR/zsh/prezto-override/zshrc ~/.zshrc
ln -s $CURDIR/zsh/prezto/runcoms/zshenv ~/.zshenv
ln -s $CURDIR/zsh/prezto/runcoms/zlogin ~/.zlogin
ln -s $CURDIR/zsh/prezto/runcoms/zlogout ~/.zlogout
ln -s $CURDIR/zsh/prezto/runcoms/zprofile ~/.zprofile
ln -s $CURDIR/zsh/prezto ~/.zprezto
ln -s $CURDIR/zsh/prezto-override/zpreztorc ~/.zpreztorc
ln -s $CURDIR/zsh ~/.zsh