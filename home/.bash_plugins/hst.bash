#!/bin/bash
#
# File: hst.bash
# Author: MarcOSDX
# Email: marcosroropeza@duck.com
# Description: This file define a hst plugin, hst print a hostname
#

function hst {
	if [[ ! -z $HOST_IP ]]; then
        unset HOST_IP
	else
	    export HOST_IP=`hostname -I | awk '{ print $1 }'`
	fi
}
