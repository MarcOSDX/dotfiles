#!/bin/bash
#
# File: theme.bash
# Author: MarcOSDX
# Email: marcosroropeza@duck.com
# Description: This file define all prompt themes for use, this theme only calleable using theme function, example: theme 'lambda'
#

# Defintion private functions
# This function draw a lambda prompt
__lambda() {
    # Dynamic variables
    local EXIT_STATUS=$?

    # Definition of colors
    local GREEN="\[\e[0;32m\]"
    local BROWN="\[\e[0;33m\]"
    local RED="\[\e[0;31m\]"
    local STOP="\[\e[m\]"

    # Definition of font styles
    local BOLD="\[\e[1m\]"
    local NORMAL="\[\e[22m\]"

    # Definitions of prompt parts
    local LAMBDA="λ"
    local DIR="${BOLD}${GREEN}\w${STOP}${NORMAL}"

	# Plugin definitions
	if [[ ! -z $HOST_IP ]]; then
		local HOST_IP_PROMPT="${BOLD}${GREEN}${HOST_IP}${STOP}${NORMAL}"
	fi

	# Extract a branch name from using git commands
    local GIT_BRANCH=`git branch 2> /dev/null | grep '^*' | awk '{ print $2 }' | sed s/"("//g`
    local GIT_PROMPT="${BOLD}${GREEN}${GIT_BRANCH}${STOP}${NORMAL}"
    if [[ ! -z $GIT_BRANCH ]]; then
        GIT_PROMPT=" ${GIT_PROMPT}"
    fi

	# If exists a AWS_PROFILE then set a AWS_PROFILE_PROMPT
    local AWS_PROFILE_PROMPT=""
    if [[ ! -z $AWS_PROFILE ]]; then
        AWS_PROFILE_PROMPT="${BOLD}${GREEN}${AWS_PROFILE}${STOP}"
    fi

	# Processing all variables using for print plugins like: `aws_profile: test`
    local PLUGIN_PROMPT=""
    if [[ ! -z $HOST_IP && ! -z $AWS_PROFILE && ! -z $GIT_BRANCH ]]; then
        PLUGIN_PROMPT=" (${BOLD}host_ip:${STOP}${HOST_IP_PROMPT} ${BOLD}branch:${STOP}${GIT_PROMPT} ${BOLD}aws_profile: ${STOP}${AWS_PROFILE_PROMPT}) "
	elif [[ ! -z $HOST_IP && ! -z $AWS_PROFILE ]]; then
		PLUGIN_PROMPT=" (${BOLD}host_ip: ${STOP}${HOST_IP_PROMPT} ${BOLD}aws_profile: ${STOP}${AWS_PROFILE_PROMPT})"
	elif [[ ! -z $HOST_IP && ! -z $GIT_BRANCH ]]; then
		PLUGIN_PROMPT=" (${BOLD}host_ip: ${STOP}${HOST_IP_PROMPT} ${BOLD}branch:${STOP}${GIT_PROMPT})" 
	elif [[ ! -z $GIT_BRANCH && ! -z $AWS_PROFILE ]]; then
		PLUGIN_PROMPT=" (${BOLD}branch:${STOP}${GIT_PROMPT} ${BOLD}aws_profile: ${STOP}${AWS_PROFILE_PROMPT})"
    elif [[ ! -z $AWS_PROFILE ]]; then
        PLUGIN_PROMPT=" (${BOLD}aws_profile: ${STOP}${AWS_PROFILE_PROMPT})" 
    elif [[ ! -z $GIT_BRANCH ]]; then
        PLUGIN_PROMPT=" (${BOLD}branch:${STOP}${GIT_PROMPT})"
	elif [[ ! -z $HOST_IP ]]; then
		PLUGIN_PROMPT=" (${BOLD}host_ip: ${STOP}${HOST_IP_PROMPT})"
    fi


    if [[ $EXIT_STATUS -eq 0 ]]; then
        PS1="${LAMBDA}${PLUGIN_PROMPT}: ${DIR}> "
    elif [[ $EXIT_STATUS -eq 148 ]]; then
        PS1="${BROWN}${LAMBDA}${STOP}${PLUGIN_PROMPT}: ${DIR}> "
    else
        PS1="${RED}${LAMBDA}${STOP}${PLUGIN_PROMPT}: ${DIR}> "
    fi
}

# Define public functions
function theme() {
    case $1 in
        'lambda')
            PROMPT_COMMAND=__lambda
         ;;

        *)
            export PS1="\u@\h:\w>"
        ;;
    esac
}
