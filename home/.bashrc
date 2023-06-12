#!/bin/bash
#
# File: .bashrc
# Author: MarcOSDX
# Email: marcosroropeza@duck.com
#

# Include another bash files
source $HOME/.bash_plugins/theme.bash
source $HOME/.bash_plugins/awp.bash 
source $HOME/.bash_plugins/hst.bash

# General settings
set -o vi # Enable vi mode for GNU/Linux CLI

# Custom settings
theme 'lambda'

# Load yarn local path into all user sesions
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Set tmp directory for TMUX
export TMUX_TMPDIR=/tmp
