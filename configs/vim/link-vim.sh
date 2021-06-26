#!/bin/bash

if [ -f $HOME/.vimrc ];then
    mv $HOME/.vimrc $HOME/.vimrc.bk
fi

if [ -d $HOME/.vim ];
   mv $HOME/.vim $HOME/.vim.bk
fi

ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/snippets $HOME/.vim/snippets
