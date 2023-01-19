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
ConfBIND9
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
ConfBIND9
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
ConfSAMBA4AD
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
ConfSAMBA4AD
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

# export all variables for functions
export $var0
export $var1
export $var2
export $var3
export $var4
export $var5
export $var6
export $var7
export $var8
export $var9
export $var10
export $var11
export $var12
export $var13
export $var14
export $var15
export $var16
export $var17
export $var18
export $var19
export $var20

# Informations is correct ?! #
printf "\n${Yellow}Informations is correct ?! (Y/N)${ResetColor}\n"
read info

if [[ "$info" =~ ^[yYoO] ]]; then
	printf "\n${Green}'OK' ${Blue}Installation starts in 3 seconds ${ResetColor}\n"
	sleep 3
elif [[ "$info" =~ ^[nN] ]]; then
	printf "\n${Red}'OK' Go to restart the script${Purple} '$0' ${ResetColor}\n"
	./"$0"
		else
                printf "\n${Red}'INPUT ERROR' Go to restart the script${Purple} '$0' ${ResetColor}\n"
	        ./"$0"
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
# Configuring SSL auto renew for Webmin through CERTBOT # UNIVERSAL VERSION # 

function ConfSSL {
printf "${Yellow}Configuring SSL auto renew for Webmin through CERTBOT${ResetColor}\n"
printf "${Red}Is this machine accessible from the outside via port 80? (Y/N)${ResetColor}\n"

read -r cert
if [[ "$cert" =~ ^[yYoO] ]]; then
printf "\n${Green}'OK' ${Blue}Installation starts in 3 seconds ${ResetColor}\n"

# installation of certbot and generation of certificates
apt install -y certbot
certbot certonly --standalone -d "$var1"."$var0"
printf "${Cyan}Certbot installed and certificate generated${Green}'OK' ${ResetColor}\n"

# add grp for automatic SSL renewal script
addgroup ssl-cert

# configure an automatic SSL renewal script
### start of renew script
cat <<EOF > /usr/local/bin/renew.sh
#!/bin/bash
###
# Automatic SSL renewal script via CERTBOT for "$var1"."$var0"
###

# move to the correct let's encrypt directory
cd /etc/letsencrypt/live/"$var1"."$var0"

# copy the files
cp cert.pem /etc/ssl/certs/"$var1"."$var0".cert.pem
cp fullchain.pem /etc/ssl/certs/"$var1"."$var0".fullchain.pem
cp privkey.pem /etc/ssl/private/"$var1"."$var0".privkey.pem

# adjust permissions of the private key
chown :ssl-cert /etc/ssl/private/"$var1"."$var0".privkey.pem
chmod 640 /etc/ssl/private/"$var1"."$var0".privkey.pem
EOF
### end of renew script

# adding rights and 1er execution
chmod u+x /usr/local/bin/renew.sh
/usr/local/bin/renew.sh

# add crontab variables
croncmd1="/usr/bin/certbot renew --quiet --renew-hook /usr/local/bin/renew.sh > /var/log/renew-ssl-cerbot.log 2>&1"
cronjob1="15 3 1 * * $croncmd1"
# add crontab
( crontab -l | grep -v -F "$croncmd1" ; echo "$cronjob1" ) | crontab -

# verify files and explanations of operation
printf "${Purple}Your ORIGINAL CERTBOT SSL certificate and chain have been saved here: \n
/etc/letsencrypt/live/$var1.$var0/fullchain.pem \n
Your CERTBOT ORIGNAL SSL key file has been saved here: \n
/etc/letsencrypt/live/$var1.$var0/privkey.pem\n\e[1;30m ${ResetColor}\n"

printf  "${Red}\nORIGINALS should not be used in applications or websites but only COPIES: ${ResetColor}\n"
printf  "${Blue}Your duplicate certificates and WITH THE RIGHT RIGHTS are registered here: ${ResetColor}"
renew1=$(ls -ahl /etc/ssl/certs/$var1.$var0*) && printf  "$renew1"
renew2=$(ls -ahl /etc/ssl/private/$var1.$var0*) && printf  "$renew2\n"
printf  "${Red}The renewal will be done automatically every 1st of the month at 3:15 a.m.${ResetColor}"
printf  "${Blue}Your log file of renew is '/var/log/renew-ssl-cerbot.log'${ResetColor}\n"
printf  "${Cyan}Configuring SSL auto-renewal script via CERTBOT ${Green}'OK'${ResetColor}\n"
sleep 3

elif [[ "$cert" =~ ^[nN] ]]; then
	printf "\n${Purple}'OK' ${Blue}SSL auto renew for Webmin through CERTBOT was 'CANCELLED'${ResetColor}\n"
        printf "${Blue}Your webmin only use the auto generated certificate by default${ResetColor}\n"
        sleep 3

        else
        printf "\n${Red}'INPUT ERROR' Go to restart the script${Purple} '$0' ${ResetColor}\n"
	./"$0"
fi
}




######################################################################
# Configuring Webmin # UNIVERSAL VERSION #

function ConfWEBMIN {
# install the necessary packages for Webmin
apt install -y shared-mime-info perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip zip

# download & install latest version of Webmin
cd /tmp
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.962_all.deb
dpkg --install webmin_1.962_all.deb
rm -dfr webmin_1.962_all.deb

# print informations & sleep 3 secondes
printf "${Cyan}Configuring Webmin ${Green}'OK' ${ResetColor}\n"
printf "${Yellow}Webmin is accessible through ${Purple}https://"$var2":10000 ${ResetColor}\n"
printf "${Yellow}Your login name : ${Purple}"$USER" ${ResetColor}\n"
sleep 3
}



######################################################################
# Configuring BIND9 #

function ConfBIND9 {
#     Config for (NS1)    #
if [ "$var1" = "ns1" ]; then
ServerIP="$var5"
printf "${Blue}Start Bind9 configuration for server "$ServerIP" ${ResetColor}\n"
fi
#     Config for (NS2)    #
if [ "$var1" = "ns2" ]; then
ServerIP="$var4"
printf "${Blue}Start Bind9 configuration for server "$ServerIP" ${ResetColor}\n"
fi

# install the necessary packages Bind9
apt install -y bind9 bind9utils bind9-doc
systemctl enable bind9
systemctl start bind9


##### /etc/bind/named.conf #####
cp /etc/bind/named.conf /etc/bind/named.conf.old
cat <<EOF > /etc/bind/named.conf
// This is the primary configuration file for the BIND DNS server named.
//
// Please read /usr/share/doc/bind9/README.Debian.gz for information on the
// structure of BIND configuration files in Debian, *BEFORE* you customize
// this configuration file.
//
// If you are just adding zones, please do that in /etc/bind/named.conf.local

include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";
include "/etc/bind/named.conf.default-zones";
server $ServerIP {
        };
EOF
##### /etc/bind/named.conf #####


##### /etc/bind/named.conf.options #####
cp /etc/bind/named.conf.options /etc/bind/named.conf.options.old
cat <<EOF > /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable
        // nameservers, you probably want to use them as forwarders.
        // Uncomment the following block, and insert the addresses replacing
        // the all-0's placeholder.

        // forwarders {
        //      0.0.0.0;
        // };

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        dnssec-validation auto;

        listen-on-v6 { any; };
        forwarders {
                $var13;
                8.8.8.8;
                };
};
EOF
##### /etc/bind/named.conf.options #####


##### cut from the ip of the srv to the first 3 blocks, example 192.168.0
ipcut=`echo $var2 |cut -d. -f 1,2,3`
##### reversal of the cut of the ip of the srv, example 0.168.192
ipcutrev=`echo $var2 | awk -F. '{print $3"."$2"."$1}'`
##### /etc/bind/named.conf.local #####
cp /etc/bind/named.conf.local /etc/bind/named.conf.local.old
cat <<EOF > /etc/bind/named.conf.local
//
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";

zone "$var0" {
        type master;
        file "/var/lib/bind/$var0.hosts";
        };
zone "$ipcutrev.in-addr.arpa" {
        type master;
        file "/var/lib/bind/$ipcut.rev";
        };
EOF
##### /etc/bind/named.conf.local #####


##### /var/lib/bind/$var0.hosts #####
cat <<EOF > /var/lib/bind/$var0.hosts
\$ttl 38400
$var0.      IN      SOA     $var1.$var0. admin.$var0. (
                        1595498695   ; serial
                        10800        ; refresh
                        3600         ; retry
                        604800       ; expiry
                        38400 )      ; minimum
;
; global
;
$var0.           IN      NS     addcp.$var0.
$var0.           IN      A      $var15
                 IN      NS     addcp
                 IN      A      $var15
addcp             IN      A      $var15
gc._msdcs        IN      A      $var15
;
; other srv
;
ns1.$var0.          IN      A     $var4
ns2.$var0.          IN      A     $var5
addcp.$var0.         IN      A     $var15
addcs.$var0.          IN      A     $var16
fichiers.$var0.          IN      A     $var19
;
; global catalog servers
;
_gc._tcp                                                IN SRV 0 100 3268       addcp
_gc._tcp.Default-First-Site-Name._sites                 IN SRV 0 100 3268       addcp
_ldap._tcp.gc._msdcs                                    IN SRV 0 100 3268       addcp
_ldap._tcp.Default-First-Site-Name._sites.gc._msdcs     IN SRV 0 100 3268       addcp
;
; ldap servers
;
_ldap._tcp                                              IN SRV 0 100 389     addcp
_ldap._tcp.dc._msdcs                                    IN SRV 0 100 389     addcp
_ldap._tcp.pdc._msdcs                                   IN SRV 0 100 389     addcp
_ldap._tcp.Default-First-Site-Name._sites               IN SRV 0 100 389     addcp
_ldap._tcp.Default-First-Site-Name._sites.dc._msdcs     IN SRV 0 100 389     addcp
;
; krb5 servers
;
_kerberos._tcp                                              IN SRV 0 100 88     addcp
_kerberos._tcp.dc._msdcs                                    IN SRV 0 100 88     addcp
_kerberos._tcp.Default-First-Site-Name._sites               IN SRV 0 100 88     addcp
_kerberos._tcp.Default-First-Site-Name._sites.dc._msdcs     IN SRV 0 100 88     addcp
_kerberos._udp                                              IN SRV 0 100 88     addcp
;
; MIT kpasswd likes to lookup this name on password change
;
_kerberos-master._tcp        IN SRV 0 100 88     addcp
_kerberos-master._udp        IN SRV 0 100 88     addcp
;
; kpasswd
;
_kpasswd._tcp           IN SRV 0 100 464     addcp
_kpasswd._udp           IN SRV 0 100 464     addcp
;
; heimdal 'find realm for host' hack
;
_kerberos               IN TXT     $var8
;
EOF
##### /var/lib/bind/$var0.hosts #####


##### reversal of the primary dns ip
ipns1rev=`echo $var4 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### reversal of the secondary dns ip
ipns2rev=`echo $var5 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### reversal of the addcp srv ip
ipaddcprev=`echo $var15 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### reversal of the addcs srv ip
ipaddcsrev=`echo $var16 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### reversal of the ip of the srv files
ipfichiersrev=`echo $var19 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### /var/lib/bind/$ipcut.rev #####
cat <<EOF > /var/lib/bind/$ipcut.rev
\$ttl 38400
$ipcutrev.in-addr.arpa.        IN      SOA     $var1.$var0. admin.$var0. (
                        1596472349
                        10800
                        3600
                        604800
                        38400 )
$ipcutrev.in-addr.arpa.      IN      NS      addcp.$var0.
$ipaddcprev.in-addr.arpa.     IN      PTR     addcp.$var0.
$ipns1rev.in-addr.arpa.      IN      PTR     ns1.$var0.
$ipns2rev.in-addr.arpa.      IN      PTR     ns2.$var0.
$ipaddcsrev.in-addr.arpa.      IN      PTR     addcs.$var0.
$ipfichiersrev.in-addr.arpa.      IN      PTR     fichiers.$var0.
EOF
##### /var/lib/bind/$ipcut.rev #####

# restart service bind9
systemctl restart bind9

printf "${Cyan}Configuring BIND9 ${Green}'OK' ${ResetColor}\n"
sleep 3
}


######################################################################
# Server configuration (ADDCP) SAMBA 4 AD DC Primary #
# OR #
# Server configuration (ADDCS) SAMBA 4 AD DC Secondary #

function ConfSAMBA4AD {
#     Banner for (ADDCP)    #
if [ "$var1" = "addcp" ]; then
printf "${Blue}Start Server configuration "$var18" SAMBA 4 AD DC Primary ${ResetColor}\n"
fi
#     Banner for (ADDCS)    #
if [ "$var1" = "addcs" ]; then
printf "${Blue}Start Server configuration "$var18" SAMBA 4 AD DC Secondary ${ResetColor}\n"
fi


##############
# /etc/fstab #
##############
cp /etc/fstab  /etc/fstab.old
# get primary partition UUID
UUID=`cat /etc/fstab | grep ext4 | awk -F/ '{print $1}'`
# deleting the line /ext4 primary partition
sed -i".bak" '/ext4/d' /etc/fstab
# creating the line /ext4 primary partition with the new attributes
echo "$UUID    /    ext4    noatime,nodiratime,user_xattr,acl,errors=remount-ro    0    1" >> /etc/fstab

printf  "${Green}\nConfigure FSTAB 'OK' ${ResetColor}\n"
printf  "${Red}\nSeveral windows will appear, just hit 'ENTER' each time ${ResetColor}\n"
sleep 20

# install packages for samba4 4 AD DC
apt install -y samba krb5-user krb5-config winbind libpam-winbind libnss-winbind acl
printf  "${Green}\nInstallation of Samba4 4 AD DC packages 'OK' ${ResetColor}\n"


##################
# /etc/krb5.conf #
##################
cp /etc/krb5.conf /etc/krb5.conf.old
cat <<EOF > /etc/krb5.conf
[libdefaults]
	default_realm = $var8
    dns_lookup_realm = false
    dns_lookup_kdc = true

# The following krb5.conf variables are only for MIT Kerberos.
	kdc_timesync = 1
	ccache_type = 4
	forwardable = true
	proxiable = true

# The following encryption type specification will be used by MIT Kerberos
# if uncommented.  In general, the defaults in the MIT Kerberos code are
# correct and overriding these specifications only serves to disable new
# encryption types as they are added, creating interoperability problems.
#
# The only time when you might need to uncomment these lines and change
# the enctypes is if you have local software that will break on ticket
# caches containing ticket encryption types it doesn't know about (such as
# old versions of Sun Java).

#	default_tgs_enctypes = des3-hmac-sha1
#	default_tkt_enctypes = des3-hmac-sha1
#	permitted_enctypes = des3-hmac-sha1

# The following libdefaults parameters are only for Heimdal Kerberos.
	fcc-mit-ticketflags = true

[realms]
	$var8 = {
		kdc = $var0
		admin_server = $var0
	}

[domain_realm]
		.$var0 = $var8
		$var0 = $var8
EOF
printf  "${Green}\nConfiguration KERBEROS 'OK' ${ResetColor}\n"


# stop old services
systemctl stop samba-ad-dc.service smbd.service nmbd.service winbind.service
systemctl disable samba-ad-dc.service smbd.service nmbd.service winbind.service

# moved old Samba 4 conf file
mv /etc/samba/smb.conf /etc/samba/smb.conf.old1


#     Config for (ADDCP)    #
if [ "$var1" = "addcp" ]; then
# creation of the samba 4 domain #
samba-tool domain provision --use-rfc2307 --realm $var8 --domain $var7 --server-role dc --dns-backend BIND9_FLATFILE --adminpass $var17
#samba-tool domain provision --use-rfc2307 --realm $var8 --domain $var7 --server-role dc --dns-backend SAMBA_INTERNAL --adminpass $var17
#samba-tool domain provision --use-rfc2307 --realm $var8 --domain $var7 --server-role dc --dns-backend BIND9_DLZ --adminpass $var17
printf  "${Green}\nCreation of the domain $var7 'OK' ${ResetColor}\n"
fi

#     Config for (ADDCS)    #
if [ "$var1" = "addcs" ]; then
# Joining the Samba4 AD DC from the ADDCP srv as a secondary domain controller #
samba-tool domain join $var0 DC -U "administrator" --password "$var17"
printf  "${Green}\nDomain join $var7 'OK' ${ResetColor}\n"
fi


# service management
systemctl unmask samba-ad-dc.service
systemctl enable samba-ad-dc.service
systemctl start samba-ad-dc.service

# information about Domain
printf  "${Blue}\nHere is the information about your SAMBA 4 AD DC domain: ${Yellow}\n"
samba-tool domain level show

# information about Kerberos
echo "$var17" | kinit administrator@$var8
printf  "${Blue}\n\nHere is your Kerberos information: ${Yellow}\n"
klist


#######################
# /etc/samba/smb.conf #
#######################

#########
#########       POUR CONTINUER IL FAUT COMPARER ADDCP ET ADDCS 
#########     


}





################################################################
#  MAIN SCRIPT START HERE
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

