" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :BundleInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
" Filetype off is required by vundle
" filetype off

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"set rtp+=$HOME/.vim/bundle/Vundle.vim/
set rtp+=~/.vim/plugs/ "Submodules

let plugs = '~/.vim/plugs/'

call plug#begin('~/.vim/vim-plugs/')
runtime languages.vim
runtime git.vim
runtime appearance.vim
runtime textobjects.vim
runtime search.vim
runtime project.vim
runtime improvements.vim
call plug#end()



" The plugins listed in ~/.vim/.vundles.local will be added here to
" allow the user to add vim plugins to yadr without the need for a fork.
"if filereadable(expand("~/.yadr/vim/.vundles.local"))
"  source ~/.vim/.vundles.local
"endif

"Filetype plugin indent on is required by vundle
" filetype plugin indent on
