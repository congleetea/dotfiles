#!/bin/bash

d=`date "+%Y-%m-%d:%H:%M:%S"`
echo ">>> link $HOME/.vimrc >>>"
if [ -f $HOME/.vimrc ];then
    mv $HOME/.vimrc $HOME/.vimrc.bk.$d
fi
ln -s $PWD/vimrc $HOME/.vimrc

echo ">>> link $HOME/.vim >>>"
if [ -d $HOME/.vim ];then
    mv $HOME/.vim $HOME/.vim.bk.$d
fi
ln -s $PWD/vim $HOME/.vim

echo ">>> download plug-vim >>>>"
if [ ! -f $HOME/.vim/autoload/plug.vim ];then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
