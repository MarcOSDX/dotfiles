#!/bin/bash
#
# File: install.sh
# Author: MarcOSDX
# Email: marcosroropeza@duck.com
#

echo "[INFO] Begin installation of marcos-roropeza dotfiles..."

if [ ! -d $HOME/.vimrc ]; then
  echo "[INFO VIMRC] Clone a vimrc configuration..."

  git clone --recursive git@github.com:MarcOSDX/vimrc.git ${HOME}/.vim > /tmp/output.log 2> /tmp/output.log
  mkdir ${HOME}/vim_backup

  echo "[INFO VIMRC] Re-direct output to /tmp/output.log"
  echo "[INFO VIMRC] Done"
else
  echo "[ERROR VIMRC] Directory vimrc in ${HOME}/.vim exists"
fi

if [ -f /usr/bin/stow ]; then
  echo "[INFO BASH] Backup and remove a current .bashrc file..."
  cp ~/.bashrc ~/.bashrc.bkp
  rm ~/.bashrc
  echo "[INFO BASH] Done"

  echo "[INFO BASH] Apply stow..."
  stow home
  echo "[INFO BASH] Done"
else
  echo "[ERROR BASH] Please install stow for continue"
fi

echo "[INFO] Done"
