#!/bin/bash
#
# File: install.sh
# Author: MarcOSDX
# Email: marcosroropeza@duck.com
#

echo "Begin installation of marcos-roropeza dotfiles..."

if [[ ! -d $HOME/.vimrc ]]; then
  echo "Clone a vimrc configuration..."
  git clone --recursive https://github.com/marcos-roropeza/vimrc $HOME/.vim
  echo "Done"
else
  echo "vimrc are installed..."
fi

if [[ -f /usr/bin/stow ]]; then
  echo "Backup and remove a current .bashrc file..."
  cp ~/.bashrc ~/.bashrc.bkp
  rm ~/.bashrc
  echo "Done"

  echo "Apply stow..."
  stow home
  echo "Done"
else
  echo "Please install stow for continue..."
fi

echo "Done"
