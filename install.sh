#!/bin/bash
echo "Building environment"
sudo apt-get install i3
sudo apt-get install stow
sudo apt-get install firefox
sudo apt-get install git

git clone git@github.com:mikelindsay/.dotfiles.git ~/.dotfiles

pushd .
cd ~/.dotfiles
git pull
popd