#!/bin/bash
echo "Building environment"
sudo apt-get install i3
sudo apt-get install stow
sudo apt-get install firefox
sudo apt-get install git
URL=git@github.com:mikelindsay/.dotfiles.git
FOLDER=~/.dotfiles
STARTINGFOLDER=$PWD
if [ ! -d "$FOLDER" ] ; then
    git clone $URL $FOLDER
else
    cd "$FOLDER"
    git pull $URL
fi
cd $CURRENTFOLDER
