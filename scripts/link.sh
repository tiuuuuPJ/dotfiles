#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
echo SCRIPT_DIR=$SCRIPT_DIR
cd $SCRIPT_DIR/../dotfiles
DOTFILES=$(find . |cut -c 3-)
echo $DOTFILES
for file in $DOTFILES
do
	ln -nsvf `pwd`/$file $HOME/$file
done
