#!/bin/bash
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

mkdir ~/.vim/undo
mkdir ~/dotbackups

for i in *
do
    mv ~/.$i ~/dotbackups
    ln -s ~/dot/$i ~/.$i
done

ln -s ~/dot/.bashrc ~/.bash_profile
vim +PluginInstall +qall
