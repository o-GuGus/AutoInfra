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
	Name=`whoami`
	sudo -l #1 not sudo #0 sudo 
	if [ $? -gt 0 ]; then
		printf "\n${Red}$Name is not a sudoers account${ResetColor}\n"
		if [ $Name = "root" ]; then
			printf "\n${Red}$Name is a good account${ResetColor}\n"
		else
			printf "\n${Yellow}Please type your 'root' account password to continue${ResetColor}\n"
			su root && bash $0
		fi
	fi
		printf "\n${Green}This a sudoers account${ResetColor}\n"
}
	
	
RootorUser







################################################################
#  SCRIPT START HERE
################################################################


BANNER
RootorUser

