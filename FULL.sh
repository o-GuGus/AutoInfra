#/bin/bash
################################################################
#  Magic_infra
################################################################
#
# Version 2.0 - 2022-09-22
#
# By Gui-Gos
#
################################################################


######################################################################
# clear screen
clear
# set color variables fo printf or echo
Black="\e[0;30m"
Red="\e[0;31m"
Green="\e[0;32m"
Yellow="\e[0;33m"
Blue="\e[0;34m"
Purple="\e[0;35m"
Cyan="\e[0;36m"
White="\e[0;37m"
Grey="\e[0;39m"
ResetColor="\e[0m"
# example of printf > printf "${Green}"$VARIABLE" or text${ResetColor}\n" <




function BANNER {
printf " ██████╗ ██╗   ██╗██╗██╗     ██╗      █████╗ ██╗   ██╗███╗   ███╗███████╗
██╔════╝ ██║   ██║██║██║     ██║     ██╔══██╗██║   ██║████╗ ████║██╔════╝
██║  ███╗██║   ██║██║██║     ██║     ███████║██║   ██║██╔████╔██║█████╗
██║   ██║██║   ██║██║██║     ██║     ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝
╚██████╔╝╚██████╔╝██║███████╗███████╗██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗
╚═════╝  ╚═════╝ ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝\n"
}





######################################################################
# check sudo or root perms #

function RootorUser {
	WhoIs=`pwd`
	Name=`whoami`
	if [ sudo -l | grep -c "may not run" -eq 1]; then
		printf "\n${Blue}$Name ${Red}is not a sudoers account${ResetColor}\n"
			if [ $Name = "root" ]; then
				printf "\n${Blue}$Name ${Red}is a good account${ResetColor}\n"
			else
				printf "\n${Yellow}Please go to 'root' account to continue${ResetColor}\n"
				su root && bash $0
			fi
	else
		printf "\n${Green}This a sudoers account${ResetColor}\n"
	fi
	

RootorUser







################################################################
#  SCRIPT START HERE
################################################################


BANNER
RootorUser

