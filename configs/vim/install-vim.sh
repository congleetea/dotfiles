#!/bin/bash

d=`date "+%Y-%m-%d:%H:%M:%S"`
echo ">>> link $HOME/.vimrc >>>"
if [ -f $HOME/.vimrc ];then
    mv $HOME/.vimrc $HOME/.vimrc.bk.$d
fi
ln -s $PWD/vimrc $HOME/.vimrc
echo ">>> make sure $HOME/.vim existed >>>"
if [ ! -d $HOME/.vim ];then
    mkdir $HOME/.vim
fi 
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//

mkdir $HOME/.vim/.backup
mkdir $HOME/.vim/.swp
mkdir $HOME/.vim/.undo

echo ">>> download plug-vim >>>>"
if [ ! -f $HOME/.vim/autoload/plug.vim ];then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi 

echo ">>> link snippets >>>>"
if  [ ! -d $HOME/.vim/snippets ];then 
    ln -s $PWD/snippets $HOME/.vim/snippets
fi

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
echo ">>>Please type PlugInstall in vim to install plugins>>>>"
echo ">>>and then restart this shell scripts to compile ycmd.>>>>"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

if [ ! -d $HOME/.vim/plugged/YouCompleteMe ];then
    echo "<<< YouCompleteMe does not exist."
    exit
fi

cd $HOME/.vim/plugged/YouCompleteMe
python3 ./install.py --clang-completer
echo "<<< Finished to install vim <<<<<<<<<"
