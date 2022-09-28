#!/bin/bash
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
██████     ██         ██████   ██████  ██  ██████   ██████  ███████ \n\n\n"
}


######################################################################
# How this script works #
function HowTo {
printf "${Cyan}This script is planned for Debian 10 Buster${ResetColor}\n"
printf "${Cyan}You must have fixed the IP adress of machines before continuing${ResetColor}\n\n"

printf "${Cyan}Here is an example of functional infrastructure:${ResetColor}\n"
printf "${Cyan}#######################################################
> Name serveur one	> NS1		> 192.168.1.201
> Name serveur two	> NS2		> 192.168.1.202
> Primary AD server	> ADDCP		> 192.168.1.203
> Secondary AD server	> ADDCS		> 192.168.1.204
> File server		> FILE		> 192.168.1.205

> User machine 1	> USER1		> 192.168.1.101
> User machine 2	> USER2		> 192.168.1.102

> Subnet Mask network	> MASK		> 255.255.255.0 /24
> Gateway of router	> GATEWAY	> 192.168.1.1
#######################################################${ResetColor}\n\n"

printf "${Cyan}For more information, please follow this link 'https://github.com/Gui-Gos/Magic_Infra/blob/402c45de9917a9185a97191149da37554d6b4b8e/README.md'${ResetColor}\n\n"
}



######################################################################
# check sudo or root perms #

function RootorUser {
	Name=$(whoami)
	printf "${Yellow}Hello '$Name' We will test if you have sudo or root permissions${ResetColor}\n"
	if [ $Name != "root" ]; then
			if ! sudo -l; then
			printf "${Red}'$Name' Is not a sudoers account${ResetColor}\n"
			printf "${Red}Please logged in on a root or admin account and restart the script "$0" ${ResetColor}\n"
			exit 1
			else
				printf "${Green}'$Name' Is a sudoers account${ResetColor}\n"
                printf "${Yellow}Please logged in on your root account now, type your 'root' password${ResetColor}\n"
                if ! sudo -u root "$0"; then
                exit 1
                fi
			fi
	else
		printf "${Green}'$Name' Is a good account${ResetColor}\n"
	fi
# if sudo -u root "$0" is launched, this condition exiting properly the first script lauched by user
if [ $Name != "root" ]; then
exit 0
fi
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
var1="ns1"; printf "${Green}Installation of ${Purple}> Name serveur one (NS1) < ${Green}is starting ${ResetColor}\n\n" # FixNAME 
SetDATA
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
var1="ns2"; printf "${Green}Installation of ${Purple}> Name serveur two (NS2) < ${Green}is starting ${ResetColor}\n\n" # FixNAME 
SetDATA
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
var1="addcp"; printf "${Green}Installation of ${Purple}> Primary AD server (ADDCP) < ${Green}is starting ${ResetColor}\n\n" # FixNAME 
SetDATA
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
var1="addcs"; printf "${Green}Installation of ${Purple}> Secondary AD server (ADDCS) < ${Green}is starting ${ResetColor}\n\n" # FixNAME 
SetDATA
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
var1="file"; printf "${Green}Installation of ${Purple}> File server (FILE) < ${Green}is starting ${ResetColor}\n\n" # FixNAME 
SetDATA
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
printf "${Purple}Name of the machine (ex: GuiGos123) in a single block without spaces or symbols:${ResetColor}\n"
read var1 # FixNAME
# Check the input value contains the alphabet and number only
valid='[:alnum:]'
while [[ "$var1" =~ [^$valid] ]]; do
	printf "${Red}Enter a machine Name with contains alphabet and number only:${ResetColor}\n"
	read var1 # FixNAME
	done
# set definitive Name of machine
var1="user-$var1"
printf "${Green}Your machine Name is ${Purple}$var1 ${ResetColor}\n\n"
# data
SetDATA
# base
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
# specific functions for this machine
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



######################################################################
# Questions #

function SetDATA {

printf "${Red}Please type answers in lowercase${ResetColor}\n\n"

printf "${Red}Domain name (ex: parlote.fr):${ResetColor}\n"
read var0

printf "${Red}Machine IP address (ex: 192.168.1.201):${ResetColor}\n"
read var2

#printf "${Red}Active Directory server name:${ResetColor}\n"
#read var3

if [ $var1 = "ns2" ] || [ $var1 = "addcp" ] || [ $var1 = "addcs" ] || [ $var1 = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}Primary DNS server (NS1) IP address (ex: 192.168.1.201):${ResetColor}\n"
read var4
fi

if [ $var1 = "ns1" ] || [ $var1 = "addcp" ] || [ $var1 = "addcs" ] || [ $var1 = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}Secondary DNS server (NS2) IP address (ex: 192.168.1.202):${ResetColor}\n"
read var5
fi

#printf "${Red}Domain admin login:${ResetColor}\n"
#read var6

# netbios domain name #
var7=$(echo "$var0" |cut -d. -f 1 | tr "[:lower:]" "[:upper:]")

# uppercase domain name #
var8=$(echo "$var0" | tr "[:lower:]" "[:upper:]")

#printf "${Red}Samba server description:${ResetColor}\n"
#read var9

#printf "${Red}Domain user group name:${ResetColor}\n"
#read var10

if [ $var1 = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}SMB common share folder name:${ResetColor}\n"
read var11
fi

printf "${Red}Subnet mask (ex: 255.255.255.0):${ResetColor}\n"
read var12

printf "${Red}Network gateway (ex: 192.168.1.1):${ResetColor}\n"
read var13

printf "${Red}Ethernet interface (ex: eth0 or ens192):${ResetColor}\n"
read var14

if [ $var1 = "ns1" ] || [ $var1 = "ns2" ] || [ $var1 = "addcs" ] || [ $var1 = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}Primary AD server (ADDCP) IP address (ex: 192.168.1.203):${ResetColor}\n"
read var15
fi

if [ $var1 = "ns1" ] || [ $var1 = "ns2" ] || [ $var1 = "addcp" ]; then
printf "${Red}Secondary AD server (ADDCS) IP address (ex: 192.168.1.204):${ResetColor}\n"
read var16
fi

if [ $var1 = "addcp" ] || [ $var1 = "addcs" ] || [ $var1 = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}Password [administrator] kerberos 'uppercase, lowercase, number, symbol':${ResetColor}\n"
read var17
fi

# uppercase hostname #
var18=$(echo "$var1" | tr "[:lower:]" "[:upper:]")

if [ $var1 = "ns1" ] || [ $var1 = "ns2" ]; then
printf "${Red}IP address of the FILE server (ex: 192.168.1.205):${ResetColor}\n"
read var19
fi

if [ $var1 = "addcs" ] || [ $var1 = "file" ]; then
printf "${Red}Password [root] for server 'ADDCP':${ResetColor}\n"
read var20
fi

# Print all data for verification #
printf "\n${Yellow}Please check the following informations:${ResetColor}\n"
printf "${Yellow}Domain name:${Green} $var0 ${ResetColor}\n"
printf "${Yellow}Machine name:${Green} $var1 ${ResetColor}\n"
printf "${Yellow}@IP:${Green} $var2 ${ResetColor}\n"
#printf "${Yellow}AD server name:${Green} $var3 ${ResetColor}\n"
printf "${Yellow}@Primary DNS IP:${Green} $var4 ${ResetColor}\n"
printf "${Yellow}@Secondary DNS IP:${Green} $var5 ${ResetColor}\n"
#printf "${Yellow}Domain admin login:${Green} $var6 ${ResetColor}\n"
printf "${Yellow}NETBIOS name:${Green} $var7 ${ResetColor}\n"
printf "${Yellow}Domain uppercase:${Green} $var8 ${ResetColor}\n"
#printf "${Yellow}Samba server description:${Green} $var9 ${ResetColor}\n"
#printf "${Yellow}Domain user group name:${Green} $var10 ${ResetColor}\n"
printf "${Yellow}SMB common share folder name:${Green} $var11 ${ResetColor}\n"
printf "${Yellow}Subnet mask:${Green} $var12 ${ResetColor}\n"
printf "${Yellow}Network Gateway:${Green} $var13 ${ResetColor}\n"
printf "${Yellow}Ethernet interface:${Green} $var14 ${ResetColor}\n"
printf "${Yellow}ADDCP srv IP address:${Green} $var15 ${ResetColor}\n"
printf "${Yellow}ADDCS srv IP address:${Green} $var16 ${ResetColor}\n"
printf "${Yellow}Administrator password:${Green} $var17 ${ResetColor}\n"
printf "${Yellow}Hostname uppercase:${Green} $var18 ${ResetColor}\n"
printf "${Yellow}File srv IP address:${Green} $var19 ${ResetColor}\n"
printf "${Yellow}ADDCP root password:${Green} $var20 ${ResetColor}\n"

# Informations is correct ?! #
printf "\n${Yellow}Informations is correct ?! (Y/N)${ResetColor}\n"
read info

if [[ "$info" =~ ^[yYoO] ]]; then
	printf "\n${Green}'OK'${Blue} Installation starts in 3 seconds ${ResetColor}\n"
	sleep 3
elif [[ "$info" =~ ^[nN] ]]; then
	printf "\n${Red}'OK' Go to restart the script${Purple} '$0' ${ResetColor}\n"
	./"$0"
		else
		printf "\n${Red}'INPUT ERROR' Please restart the script${Purple} '$0' ${ResetColor}\n"
		exit 1
fi
}



################################################################
#  BASE FUNCTION FOR ALL MACHINES
################################################################

######################################################################
# Configuring SSH for root login #

function ConfSSH {
apt -y install openssh-server
systemctl enable ssh
systemctl start ssh

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.old

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

printf "${Cyan}Configuring SSH for root login ${Green}'OK' ${ResetColor}\n"
sleep 3
}



######################################################################
# Configuration of "ll & nn" alias #

function ConfSHORTS {
cp ~/.bashrc ~/.bashrc.old

cat <<EOF > ~/.bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='\${debian_chroot:+(\$debian_chroot)}\h:\w$ '
# umask 022

# You may uncomment the following lines if you want 'ls' to be colorized:
export LS_OPTIONS='--color=auto'
# eval "'dircolors'"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -ahl'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'

# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
# alias ll='ls -ahl'

# alias for nano
alias nn='nano'
EOF

printf "${Cyan}Configuration of shortcuts (ll & nn) ${Green}'OK' ${ResetColor}\n"
sleep 3
}


######################################################################
# Configuring the sbin PATH #

function ConfPATH {
echo "# Configuring the sbin PATH" >> ~/.bashrc
echo "export PATH=/usr/local/sbin:/usr/sbin:/sbin:$PATH" >> ~/.bashrc
# bashrc reload
. ~/.bashrc

printf "${Cyan}Configuring the sbin PATH ${Green}'OK' ${ResetColor}\n"
sleep 3
}


######################################################################
# NETWORK Setup #

function ConfNETWORK {
# install apt package for name resolution with resolvconf on Linux Debian
apt -y install resolvconf

cp /etc/network/interfaces /etc/network/interfaces.old

echo "# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).
source /etc/network/interfaces.d/*
# The loopback network interface
auto lo
iface lo inet loopback
# The primary network interface
allow-hotplug $var14
# iface $var14 inet dhcp # disable dhcp and set static ip
iface $var14 inet static
#machine ip address
        address $var2
        netmask $var12
        gateway $var13
#primary dns srv ip address
        dns-nameservers $var4
#secondary dns srv ip address
        dns-nameservers $var5
#default search domain
        dns-search $var0" > /etc/network/interfaces

printf "${Cyan}NETWORK Setup ${Green}'OK' ${ResetColor}\n"
sleep 3
}


######################################################################
# Configuring the HOSTS file #

function ConfHOSTS {
cp /etc/hosts  /etc/hosts.old

echo "127.0.0.1       localhost
$var2     $var1.$var0     $var1

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts

printf "${Cyan}Configuring the HOSTS file ${Green}'OK' ${ResetColor}\n"
sleep 3
}


######################################################################
# Configuring the HOSTNAME #

function ConfHOSTNAME {
cp /etc/hostname  /etc/hostname.old
echo "$var1" > /etc/hostname
hostname $var1

printf "${Cyan}Configuring the HOSTNAME ${Green}'OK' ${ResetColor}\n"

# reboot the network service
/etc/init.d/networking restart
ifup $var14

sleep 3
}



######################################################################
# Configuring the sources.list file #

function ConfSOURCES {
cp /etc/apt/sources.list /etc/apt/sources.list.old

echo "#deb cdrom:[Debian GNU/Linux 10 _Buster_ - Official amd64 NETINST]/ buster main

deb http://deb.debian.org/debian/ buster main contrib non-free
deb-src http://deb.debian.org/debian/ buster main contrib non-free

deb http://security.debian.org/debian-security buster/updates main contrib non-free
deb-src http://security.debian.org/debian-security buster/updates main contrib non-free

# buster-updates, previously known as 'volatile'
deb http://deb.debian.org/debian/ buster-updates main contrib non-free
deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching 'deb cdrom'
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual." > /etc/apt/sources.list

printf "${Cyan}Configuring the sources.list file ${Green}'OK' ${ResetColor}\n"
sleep 3
}


#####################################################################
# Updates #

function GoUPDATES {
apt update
apt dist-upgrade -y

printf "${Cyan}Updates ${Green}'OK' ${ResetColor}\n"
sleep 3
}


######################################################################
# Configuring SSL auto renew for Webmin through CERTBOT # A REVOIR COMPLETEMENT # UNIVERSAL VERSION # 

function ConfSSL {

echo  "\e[1;34m\nConfiguration du SSL via certbot\n\e[1;30m"
echo  "\e[1;31m\nCette machine est elle accessible de l'exterieur via le port 80 ? (Y/N)\n"
read cert
echo "\e[1;30m"
case $cert in

[yYoO]*)
# installation de certbot et generation des certificats
apt install -y certbot
	certbot certonly --standalone -d $var1.$var0
echo  "\e[1;32m\nConfiguration du SSL via certbot 'OK'\n\e[1;30m"

# configuration d'un script de renouvellement automatique du SSL
echo  "\e[1;34m\nConfiguration d'un script de renouvellement automatique du SSL via CERTBOT\n\e[1;30m"
 addgroup ssl-cert

###
FullHostName="$var1.$var0"
### debut script renew
cat <<EOF > /tmp/renew.sh
#!/bin/bash
###
# Automatic SSL renewal script via CERTBOT for $FullHostName
###

# move to the correct let's encrypt directory
cd /etc/letsencrypt/live/$FullHostName

# copy the files
cp cert.pem /etc/ssl/certs/$FullHostName.cert.pem
cp fullchain.pem /etc/ssl/certs/$FullHostName.fullchain.pem
cp privkey.pem /etc/ssl/private/$FullHostName.privkey.pem

# adjust permissions of the private key
chown :ssl-cert /etc/ssl/private/$FullHostName.privkey.pem
chmod 640 /etc/ssl/private/$FullHostName.privkey.pem
EOF
### fin script renew

# ajout des droits et execution
chmod u+x /usr/local/bin/renew.sh
/usr/local/bin/renew.sh

# ajout crontab
croncmd1="/usr/bin/certbot renew --quiet --renew-hook /usr/local/bin/renew.sh > /var/log/renew-ssl-cerbot.log 2>&1"
cronjob1="15 3 1 * * $croncmd1"
( crontab -l | grep -v -F "$croncmd1" ; echo "$cronjob1" ) | crontab -

# verification de la presence des fichiers et explication
echo  "\e[1;33m\nVotre certificat et votre chaine SSL CERTBOT ORIGINAUX ont ete enregistres ici :
   /etc/letsencrypt/live/$var1.$var0/fullchain.pem
   Votre fichier cle SSL CERTBOT ORIGNAL a ete enregistre ici :
   /etc/letsencrypt/live/$var1.$var0/privkey.pem\n\e[1;30m"

echo  "\e[1;31m\nIl ne faut pas utiliser les ORIGINAUX dans les applications ou sites web mais uniquement les COPIES :\e[1;30m"
echo  "\e[1;34mVos certificats dupliques et AVEC LES BONS DROITS sont enregistres ici :"
renew1=$(ls -ahl /etc/ssl/certs/$var1.$var0*)
renew2=$(ls -ahl /etc/ssl/private/$var1.$var0*)
echo  "$renew1"
echo  "$renew2 \e[1;30m"
echo  "\e[1;31m\nLe renouvellement se fera automatiquement tous les 1er du mois a 3h15\n\e[1;30m"
echo  "\e[1;32m\nConfiguration du script de renouvellement automatique du SSL via CERTBOT 'OK'\n\e[1;30m"
sleep 3;;

[nN]*)
echo  "\e[1;33m\nConfiguration du SSL via certbot 'ANNULEE'\n\e[1;30m"
sleep 3;;

*) echo "\e[1;31m\nERREUR de saisie, veuillez relancer le script $0\n\e[30m"
exit 1;;

esac

}




######################################################################
# Configuring Webmin # UNIVERSAL VERSION #

function ConfWEBMIN {

# Install the necessary packages for Webmin
apt install -y shared-mime-info perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip zip

# Download & install latest version of Webmin
cd /tmp
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.962_all.deb
dpkg --install webmin_1.962_all.deb
rm -dfr webmin_1.962_all.deb

# Print informations & sleep 3 secondes
printf "${Cyan}Configuring Webmin ${Green}'OK' ${ResetColor}\n"
printf "${Yellow}Webmin is accessible through ${Purple}https://"$var2":10000 ${ResetColor}\n"
printf "${Yellow}Your login name : ${Purple}"$USER" ${ResetColor}\n"
sleep 3
}


################################################################
#  SCRIPT START HERE
################################################################

BANNER1
BANNER2
HowTo
RootorUser
ChoiceMenu

# enable ssh login for root user ?! #
printf "\n${Yellow}Do you want to enable ssh login for root user ?! (Y/N)${ResetColor}\n"
read sshroot
if [[ "$sshroot" =~ ^[yYoO] ]]; then
	printf "\n${Green}'OK'${Blue} Enable ssh login for root user ${ResetColor}\n"
	ConfSSH
else
	printf "\n${Green}'OK'${Blue} Not enable ssh login for root user ${ResetColor}\n"
	apt -y install openssh-server
	systemctl enable ssh
	systemctl start ssh
fi

# base

# The rest of the specific workflow for each machine is located just above

