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
# set color variables for printf or echo
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
# example 'printf "${Green}"$VARIABLE" or text${ResetColor}\n"'






######################################################################
# Banners #

function BANNER1 { # ANSI Shadow
printf "███╗   ███╗ █████╗  ██████╗ ██╗ ██████╗    ██╗███╗   ██╗███████╗██████╗  █████╗ 
████╗ ████║██╔══██╗██╔════╝ ██║██╔════╝    ██║████╗  ██║██╔════╝██╔══██╗██╔══██╗
██╔████╔██║███████║██║  ███╗██║██║         ██║██╔██╗ ██║█████╗  ██████╔╝███████║
██║╚██╔╝██║██╔══██║██║   ██║██║██║         ██║██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║
██║ ╚═╝ ██║██║  ██║╚██████╔╝██║╚██████╗    ██║██║ ╚████║██║     ██║  ██║██║  ██║
╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝ ╚═════╝    ╚═╝╚═╝  ╚═══╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝\n"
}

function BANNER2 { # ANSI Regular
printf "██████  ██    ██      ██████  ██    ██ ██  ██████   ██████  ███████ 
██   ██  ██  ██      ██       ██    ██ ██ ██       ██    ██ ██      
██████    ████       ██   ███ ██    ██ ██ ██   ███ ██    ██ ███████ 
██   ██    ██        ██    ██ ██    ██ ██ ██    ██ ██    ██      ██ 
██████     ██         ██████   ██████  ██  ██████   ██████  ███████ \n\n"
}


######################################################################
# How this script works #
function HowTo {
printf "${Cyan}This script is planned for Debian 10 Buster${ResetColor}\n"
printf "${Cyan}You must have fixed the IP adress of machines before continuing${ResetColor}\n\n"

printf "${Cyan}Here is an example of functional infrastructure:${ResetColor}\n"
printf "${Cyan}#######################################################
> Name serveur one		> NS1 		> 192.168.1.201
> Name serveur two		> NS2 		> 192.168.1.202
> Primary AD server     > ADDCP 	> 192.168.1.203
> Secondary AD server	> ADDCS 	> 192.168.1.204
> File server		    > FILE 	    > 192.168.1.205

> User machine 1		> USER1 	> 192.168.1.101
> User machine 2		> USER2 	> 192.168.1.102

> Subnet Mask network   > MASK  	> 255.255.255.0 /24
> Gateway of router	    > GATEWAY 	> 192.168.1.1
#######################################################${ResetColor}\n\n"

printf "${Cyan}For more information, please follow this link 'https://github.com/Gui-Gos/Magic_Infra/blob/402c45de9917a9185a97191149da37554d6b4b8e/README.md'${ResetColor}\n\n"
}



######################################################################
# check sudo or root perms #

function RootorUser {
    Name=$(whoami)
    printf "${Yellow}Hello '$Name' We will test if you have sudo permissions${ResetColor}\n"
    printf "${Yellow}Please type your password now${ResetColor}\n"
	sudo -l #1 not sudo #0 sudo 
	if [ $? -gt 0 ]; then
		printf "${Red}$Name Is not a sudoers account${ResetColor}\n"
		if [ $Name = "root" ]; then
			printf "${Green}$Name Is a good account${ResetColor}\n"
		else
			printf "${Yellow}Please type your 'root' account password to continue${ResetColor}\n"
			su root && bash $0
		fi
	fi
		printf "${Green}This a sudoers account${ResetColor}\n"
}




######################################################################
# Choice menu for deployement #

function ChoiceMenu {
printf "${Yellow}Which server/user do you want to deploy:${ResetColor}\n"
printf "${Yellow}1) ${Cyan}Name serveur one     (NS1)${ResetColor}\n"
printf "${Yellow}2) ${Cyan}Name serveur two     (NS2)${ResetColor}\n"
printf "${Yellow}3) ${Cyan}Primary AD server    (ADDCP)${ResetColor}\n"
printf "${Yellow}4) ${Cyan}Secondary AD server  (ADDCS)${ResetColor}\n"
printf "${Yellow}5) ${Cyan}File server          (FILE)${ResetColor}\n"
printf "${Yellow}6) ${Cyan}User machine         (USER)${ResetColor}\n"
printf "${Yellow}q) ${Cyan}For Exit                   ${ResetColor}\n\n"

read choice
case $choice in

1) # Name serveur one     (NS1)
GetDATA
FixNAME
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
ConfSSL
ConfWEBMIN
ConfBIND9Primary
ConfNTPClient
GoReboot
;;

2) # Name serveur two     (NS2)
GetDATA
FixNAME
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
ConfSSL
ConfWEBMIN
ConfBIND9Secondary
ConfNTPClient
GoReboot
;;

3) # Primary AD server    (ADDCP)
GetDATA
FixNAME
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
ConfSSL
ConfWEBMIN
ConfSAMBA4ADDCPrimary
ConfRSYNCsrv
ConfNTPServer
GoReboot
;;


4) # Secondary AD server  (ADDCS)
GetDATA
FixNAME
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
ConfSSL
ConfWEBMIN
ConfSAMBA4ADDCSecondary
ConfRSYNCget
ConfNTPClient
GoReboot
;;

5) # File server          (FILE)
GetDATA
FixNAME
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
ConfSSL
ConfWEBMIN
ConfFILEServer
ConfDIRECTORYCommon
ConfNTPClient
GoReboot
;;

6) # User machine         (USER)
GetDATA
FixNAME
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
JoinDOMAIN
JoinFILE
ConfENVGra
ConfCOMMON
ConfNTPClient
GoReboot
;;

# Exit
q)
exit 0
;;

# Other
*)
printf "${Red}Input error, please restart the script $0 ${ResetColor}\n"
exit 1
;;
esac
}



################################################################
#  SCRIPT START HERE
################################################################

BANNER1 
BANNER2 
HowTo
RootorUser
ChoiceMenu



