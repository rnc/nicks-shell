#!/bin/bash
#
#
# Setup script

nspwd=$(dirname "$(readlink -f "$0")")
kspwd=$(dirname "$nspwd")/kde-scripts

echo "Setting up symbolic links with nicks-shell as $nspwd and kde-scripts as $kspwd"

cd $HOME
rm -f .bashrc 

ln -s $nspwd/.aliases
ln -s $nspwd/.bashrc
ln -s $nspwd/.commonshell
ln -s $nspwd/.tmux.conf
ln -s $nspwd/.zshenv
ln -s $nspwd/.zshrc
ln -s $kspwd/.Xmodmap



	      


