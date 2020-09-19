#!/bin/bash
# Shell script to link the dotfiles for the user after cloning the repo
# Note: since this shell script, like the rest of the repository, is made for my own personal convenience, I'm making some heavy assumptions which will always be true for me, but may not for someone else using this script.
# Mainly that you cloned this repo into the home folder of the user who wants these configs

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.xinitrc ~/.xinitrc
ln -s ~/dotfiles/.xprofile ~/.xprofile
ln -s ~/dotfiles/awesome/rc.lua ~/.config/awesome/rc.lua 
ln -s ~/dotfiles/awesome/theme.lua ~/.config/awesome/theme.lua 
