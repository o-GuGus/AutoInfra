#!/bin/bash
################################################################################
# Name : AutoInfra
# Author: o-GuGus
# Creation Date: 2020-09-28   Revision Date : 2023-04-25
# Description: Bash script for infrastructure deployment on Debian 
# Usage: /bin/bash -c "$(curl -sSL https://raw.githubusercontent.com/o-GuGus/AutoInfra/master/deploy.sh)"
# Notes: Any special notes about the script
# References: List any references used in the script, such as tutorials or manuals
################################################################################

################################################################################
### Terminal Colors and Screen Clearing ###
clear
# Set color variables for printf or echo
Red="\e[0;31m"
Green="\e[0;32m"
Yellow="\e[0;33m"
Blue="\e[0;34m"
Purple="\e[0;35m"
Cyan="\e[0;36m"
ResetColor="\e[0m"
# example (printf "${Green}%s${ResetColor}\n" "Hello in green color")
################################################################################

################################################################################
### Banners with ASCII art in Bash ###
function BANNER { # ANSI Shadow & ANSI Regular
printf " █████╗ ██╗   ██╗████████╗ ██████╗ ██╗███╗   ██╗███████╗██████╗  █████╗ 
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██║████╗  ██║██╔════╝██╔══██╗██╔══██╗
███████║██║   ██║   ██║   ██║   ██║██║██╔██╗ ██║█████╗  ██████╔╝███████║
██╔══██║██║   ██║   ██║   ██║   ██║██║██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║
██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║██║ ╚████║██║     ██║  ██║██║  ██║
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝\n"
printf "██████  ██    ██      ██████  ██    ██  ██████  ██    ██ ███████ 
██   ██  ██  ██      ██       ██    ██ ██       ██    ██ ██      
██████    ████       ██   ███ ██    ██ ██   ███ ██    ██ ███████ 
██   ██    ██        ██    ██ ██    ██ ██    ██ ██    ██      ██ 
██████     ██         ██████   ██████   ██████   ██████  ███████ \n\n\n"
}
################################################################################

################################################################################
# How this script works #
function HowTo {
printf "${Cyan}%s${ResetColor}\n"       "This script is planned for Debian 10 Buster"
printf "${Cyan}%s${ResetColor}\n\n"     "You must have fixed the IP adress of machines before continuing"
printf "${Cyan}%s${ResetColor}\n"       "Here is an example of functional infrastructure:"
printf "${Cyan}%s${ResetColor}\n" "+----------------------+--------+---------------+"
printf "${Cyan}%s${ResetColor}\n" "|       EQUIPMENT      |  NAME  |    IP ADDRESS |"
printf "${Cyan}%s${ResetColor}\n" "+----------------------+--------+---------------+"
printf "${Cyan}%s${ResetColor}\n" "| Name server one      |   NS1  | 192.168.1.201 |"
printf "${Cyan}%s${ResetColor}\n" "| Name server two      |   NS2  | 192.168.1.202 |"
printf "${Cyan}%s${ResetColor}\n" "| Primary AD server    |  ADDCP | 192.168.1.203 |"
printf "${Cyan}%s${ResetColor}\n" "| Secondary AD server  |  ADDCS | 192.168.1.204 |"
printf "${Cyan}%s${ResetColor}\n" "| File server          |  FILE  | 192.168.1.205 |"
printf "${Cyan}%s${ResetColor}\n" "+----------------------+--------+---------------+"
printf "${Cyan}%s${ResetColor}\n" "| User machine 1       |  USER1 | 192.168.1.101 |"
printf "${Cyan}%s${ResetColor}\n" "| User machine 2       |  USER2 | 192.168.1.102 |"
printf "${Cyan}%s${ResetColor}\n" "+----------------------+--------+---------------+"
printf "${Cyan}%s${ResetColor}\n" "| Subnet mask network  |   MASK | 255.255.255.0 |"
printf "${Cyan}%s${ResetColor}\n" "| Gateway of router    | GATEWAY| 192.168.1.1   |"
printf "${Cyan}%s${ResetColor}\n\n" "+----------------------+--------+---------------+"
printf "${Cyan}%s${ResetColor}\n\n"     "For more information, please follow this link 'https://raw.githubusercontent.com/o-GuGus/AutoInfra/master/infra.md'"
}

################################################################################
# check sudo or root perms #
function RootOrUser {
	Name=$(whoami)
	printf "${Blue}%s${ResetColor}\n" "Hello '$Name' We will test if you have sudo or root permissions"
	if [ $Name != "root" ]; then
		if ! sudo -l; then
		printf "${Red}%s${ResetColor}\n" "'$Name' Is not a sudoers account"
		printf "${Red}%s${ResetColor}\n" "Please logged in on a root or admin account and restart the script '$0'"
		exit 1
		else
		printf "${Green}%s${ResetColor}\n"  "'$Name' Is a sudoers account"
                printf "${Yellow}%s${ResetColor}\n" "Please logged in on your root account now, type your 'root' password"
                        if ! sudo -u root "$0"; then
                        exit 1
                        fi
		fi
	else
		printf "${Green}%s${ResetColor}\n" "'$Name' Is a good account"
	fi
# if sudo -u root "$0" is launched, this condition exiting properly the first script lauched by user
if [ $Name != "root" ]; then
exit 0
fi
}
################################################################################

################################################################################
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

# Export all variables for functions, from 0 to 20
for i in {0..20}; do
  export var$i
done

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
cd /tmp || exit 1
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.962_all.deb
dpkg --install webmin_1.962_all.deb
rm -dfr webmin_1.962_all.deb

# print informations & sleep 3 secondes
printf "${Cyan}Configuring Webmin ${Green}'OK' ${ResetColor}\n"
printf "${Yellow}Webmin is accessible through ${Purple}https://$var2:10000 ${ResetColor}\n"
printf "${Yellow}Your login name : ${Purple}$USER ${ResetColor}\n"
sleep 3
}



######################################################################
# Configuring BIND9 #

function ConfBIND9 {
#     Config for (NS1)    #
if [ "$var1" = "ns1" ]; then
ServerIP="$var5"
printf "${Blue}Start Bind9 configuration for server $ServerIP ${ResetColor}\n"
fi
#     Config for (NS2)    #
if [ "$var1" = "ns2" ]; then
ServerIP="$var4"
printf "${Blue}Start Bind9 configuration for server $ServerIP ${ResetColor}\n"
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
ipcut=$(echo $var2 |cut -d. -f 1,2,3)
##### reversal of the cut of the ip of the srv, example 0.168.192
ipcutrev=$(echo $var2 | awk -F. '{print $3"."$2"."$1}')
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
ipns1rev=$(echo $var4 | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the secondary dns ip
ipns2rev=$(echo $var5 | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the addcp srv ip
ipaddcprev=$(echo $var15 | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the addcs srv ip
ipaddcsrev=$(echo $var16 | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the ip of the srv files
ipfichiersrev=$(echo $var19 | awk -F. '{print $4"."$3"."$2"."$1}')
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
printf "${Blue}Start Server configuration $var18 SAMBA 4 AD DC Primary ${ResetColor}\n"
fi
#     Banner for (ADDCS)    #
if [ "$var1" = "addcs" ]; then
printf "${Blue}Start Server configuration $var18 SAMBA 4 AD DC Secondary ${ResetColor}\n"
fi


##############
# /etc/fstab #
##############
cp /etc/fstab  /etc/fstab.old
# get primary partition UUID
UUID=$(cat /etc/fstab | grep ext4 | awk -F/ '{print $1}')
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
cp /etc/samba/smb.conf /etc/samba/smb.conf.old2
cat <<EOF > /etc/samba/smb.conf
# Global parameters
[global]
    netbios name = $var18
    workgroup = $var7
    realm = $var8
    server role = active directory domain controller
    idmap_ldb:use rfc2307 = yes
      dns forwarder = $var4,$var5

# logs
log file = /var/log/samba/%m.log
log level = 1

# acl
vfs objects = acl_xattr
map acl inherit = yes
store dos attributes = yes

# template homedir & shell
template homedir = /home/%D/%U
template shell = /bin/bash

# winbind
winbind use default domain = yes
winbind offline logon = false
winbind nss info = rfc2307
winbind enum users = yes
winbind enum groups = yes

# Desactiver les connections null session
restrict anonymous = 2

# Desactiver NetBIOS
disable netbios = yes

# Desactiver le support des imprimantes
printcap name = /dev/null
load printers = no
disable spoolss = yes
printing = bsd

# Generer des hashes de mot de passe supplementaires
password hash userPassword schemes = CryptSHA256 CryptSHA512

# Desactiver NTLMv1
ntlm auth = mschapv2-and-ntlmv2-only

# dossiers
    [netlogon]
        path = /var/lib/samba/sysvol/$var0/scripts
        read only = No

    [sysvol]
        path = /var/lib/samba/sysvol
        read only = No
EOF

# reboot service samba 4 ad dc
systemctl restart samba-ad-dc.service

printf "${Green}\nConfiguring /etc/samba/smb.conf 'OK' ${ResetColor}\n"


####################
# NSS login system #
####################

# creer un repertoire personnel lors de la connexion
pam-auth-update --enable mkhomedir
printf "${Green}\nHome directory has connection 'OK' ${ResetColor}\n"

# pour pouvoir authentifier et ouvrir une session ad sur le systeme local
cp /etc/nsswitch.conf /etc/nsswitch.conf.old
cat <<EOF > /etc/nsswitch.conf
# /etc/nsswitch.conf
#
# Example configuration of GNU Name Service Switch functionality.
# If you have the 'glibc-doc-reference' and 'info' packages installed, try:
# 'info libc Name Service Switch' for information about this file.

passwd:         compat winbind
group:          compat winbind
shadow:         compat winbind
gshadow:        files

hosts:          files dns
networks:       files

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
EOF
printf "${Green}\nConfigure NSS 'OK' ${ResetColor}\n"

# suppression de "try_authtok"
# les utilisateurs authentifies localement sur linux ne peuvent pas modifier leur mot de passe depuis la console
cp /etc/pam.d/common-password /etc/pam.d/common-password.old
cat <<EOF > /etc/pam.d/common-password
#
# /etc/pam.d/common-password - password-related modules common to all services
#
# This file is included from other service-specific PAM config files,
# and should contain a list of modules that define the services to be
# used to change user passwords.  The default is pam_unix.

# Explanation of pam_unix options:
#
# The "sha512" option enables salted SHA512 passwords.  Without this option,
# the default is Unix crypt.  Prior releases used the option "md5".
#
# The "obscure" option replaces the old 'OBSCURE_CHECKS_ENAB' option in
# login.defs.
#
# See the pam_unix manpage for other options.

# As of pam 1.0.1-6, this file is managed by pam-auth-update by default.
# To take advantage of this, it is recommended that you configure any
# local modules either before or after the default block, and use
# pam-auth-update to manage selection of other modules.  See
# pam-auth-update(8) for details.

# here are the per-package modules (the "Primary" block)
password        [success=2 default=ignore]      pam_unix.so obscure sha512

### ancienne ligne ###
### password        [success=1 default=ignore]      pam_winbind.so try_authtok try_first_pass

### nouvelle ligne ###
password        [success=1 default=ignore]      pam_winbind.so try_first_pass

# here's the fallback if no module succeeds
password        requisite                       pam_deny.so
# prime the stack with a positive return value if there isn't one already;
# this avoids us returning an error just because nothing sets a success code
# since the modules above will each just jump around
password        required                        pam_permit.so
# and here are more per-package modules (the "Additional" block)
# end of pam-auth-update config
EOF
printf "${Green}\nRemove try_authtok 'OK'${ResetColor}\n"

# les binaires Samba4 sont livres avec un demon winbind integre et active par defaut
# desactivation du demon winbind fourni par le package winbind a partir des referentiels debian officiels
systemctl disable winbind.service
systemctl stop winbind.service

printf "${Blue}\n\nHere is the information of the groups currently present on the domain ${Yellow}\n"
wbinfo -g

printf "${Blue}\n\nHere is the list of users currently present on the domain ${Yellow}\n"
wbinfo -u
getent passwd | grep $var7

printf "${Blue}\n\nHere are the password settings for your domain ${Yellow}\n"
samba-tool domain passwordsettings show
sleep 3

#     Config for (ADDCP)    #
if [ "$var1" = "addcp" ]; then
printf "${Green}\nConfiguring SAMBA 4 AD DC Primary 'OK' ${ResetColor}\n"
sleep 3
fi

#     Config for (ADDCS)    #
if [ "$var1" = "addcs" ]; then
printf "${Green}\nConfiguring SAMBA 4 AD DC Secondary 'OK' ${ResetColor}\n"
sleep 3
fi
}


#################################################################
# SysVol replication from the first domain controller via Rsync #
function ConfRSYNCSysVol {

#     Config for (ADDCP)    #
if [ "$var1" = "addcp" ]; then
apt install -y rsync
printf "${Green}\nSysVol replication SERVER 'OK' ${ResetColor}\n"
sleep 3
fi

#     Config for (ADDCS)    #
if [ "$var1" = "addcs" ]; then
printf "${Blue}\nSysVol CLIENT replication being configured ${ResetColor}\n"

# installation des paquets
apt install -y rsync sshpass

# generation d'une cle ssh
ssh-keygen -t rsa -f /root/.ssh/rsa_SysVol -q -P ""

# copie de la cle sur le serveur ADDCP
sshpass -p $var20 ssh-copy-id -i /root/.ssh/rsa_SysVol root@addcp -f

# test de replication
sshpass -p $var20 rsync -XAavz --chmod=775 --delete-after --progress --stats -e "ssh -o StrictHostKeyChecking=no" root@addcp:/var/lib/samba/sysvol/ /var/lib/samba/sysvol/

# stockage du pass pour syncro cron
echo "$var20" > /root/.ssh/SysVol_pass
chmod 600 /root/.ssh/SysVol_pass

# ajout d'une tache automatique cron toutes les 5 minutes
croncmd2="sshpass -f /root/.ssh/SysVol_pass rsync -XAavz --chmod=775 --delete-after --progress --stats root@addcp:/var/lib/samba/sysvol/ /var/lib/samba/sysvol/ > /var/log/sysvol-replication.log 2>&1"
cronjob2="*/5 * * * * $croncmd2"
( crontab -l | grep -v -F "$croncmd2" ; echo "$cronjob2" ) | crontab -

printf "${Green}\nConfiguring SysVol Replication CLIENT 'OK' ${ResetColor}\n"
sleep 3
fi
}


######################################################################
# Configuration du serveur NTP #
function ConfNTPServer {
apt install -y ntp ntpdate

cp /etc/ntp.conf /etc/ntp.conf.old
cat <<EOF > /etc/ntp.conf
# Path for file used to store the frequency offset between the system clock and NTP time servers
driftfile /var/lib/ntp/ntp.drift

# Path for the socket used by ntpd to communicate with Samba's ntp_signd daemon (for signing NTP packets)
ntpsigndsocket /var/lib/samba/ntp_signd/

# Leap seconds definition provided by tzdata
leapfile /usr/share/zoneinfo/leap-seconds.list

# Enable this if you want statistics to be logged.
#statsdir /var/log/ntpstats/
statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

# Configure NTP time servers to synchronize with (here using the pool.ntp.org DNS names)
server 0.pool.ntp.org
server 1.pool.ntp.org
server 2.pool.ntp.org
server 3.pool.ntp.org

# By default, exchange time with everybody, but don't allow configuration.
restrict -4 default kod notrap nomodify nopeer noquery limited
restrict -6 default kod notrap nomodify nopeer noquery limited

# Local users may interrogate the ntp server more closely.
restrict 127.0.0.1
restrict ::1

# Needed for adding pool entries
restrict source nomodify notrap noquery mssntp
restrict default kod nomodify notrap nopeer mssntp

# Disable panic mode (0=don't panic)
tinker panic 0
EOF

# application des droits
chown root:ntp /var/lib/samba/ntp_signd/
chmod 750 /var/lib/samba/ntp_signd/

# restart ntp service
systemctl restart ntp

# verification du ntp
printf "${Yellow}\nVerification des pairs du serveur ntp ${ResetColor}\n"
ntpq -p

printf "${Green}\nConfiguration du serveur NTP 'OK' ${ResetColor}\n"
sleep 3
}


######################################################################
# Configuration du Client NTP #
function ConfNTPClient {
apt install -y ntp ntpdate

cp /etc/ntp.conf /etc/ntp.conf.old
cat <<EOF > /etc/ntp.conf
# Path for file used to store the frequency offset between the system clock and NTP time servers
driftfile /var/lib/ntp/ntp.drift

# Configure NTP time servers to synchronize with (here using the server $var15 DNS names)
server $var15
pool $var0

# By default, exchange time with everybody, but don't allow configuration.
restrict -4 default kod notrap nomodify nopeer noquery limited
restrict -6 default kod notrap nomodify nopeer noquery limited

# Local users may interrogate the ntp server more closely.
restrict 127.0.0.1
restrict ::1

# Needed for adding pool entries
restrict default kod nomodify notrap nopeer mssntp

# Disable panic mode (0=don't panic)
tinker panic 0
EOF

# restart ntp service
systemctl restart ntp

# verification du ntp
printf "${Yellow}\nVerification des pairs du Client NTP ${ResetColor}\n"
ntpq -p

printf "${Yellow}\nSynchronisation avec le serveur NTP du domaine $var0 ${ResetColor}\n"
ntpdate -bu $var0

# ajout d'une tache automatique cron toutes les jours a 23hx pour la syncro de l'heure avec le domaine
chiffre=$(awk -v min=1 -v max=59 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
croncmd3="/usr/sbin/ntpdate -bu $var0 > /var/log/ntp.log 2>&1"
cronjob3="*/$chiffre 23 * * * $croncmd3"
( crontab -l | grep -v -F "$croncmd3" ; echo "$cronjob3" ) | crontab -

printf "${Green}\nConfiguration du Client NTP 'OK' ${ResetColor}\n"
sleep 3
}

#####################################################################
# Reboot #
function GoReboot {
printf "${Red}\nVotre serveur va redemmarrer dans 5 secondes .....\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 4 secondes ....\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 3 secondes ...\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 2 secondes ..\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 1 secondes . ${ResetColor}\n"
sleep 1
systemctl reboot
}

################################################################
################################################################
#  MAIN SCRIPT START HERE
################################################################
################################################################
# Banners 
BANNER
#
RootOrUser
#
HowTo
###############################
# Choice menu for deployement #
printf "${Yellow}%s${ResetColor}\n"                             "Which server/user do you want to deploy:"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "1)" "Name serveur one" "(NS1)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "2)" "Name serveur two" "(NS2)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "3)" "Primary AD server" "(ADDCP)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "4)" "Secondary AD server" "(ADDCS)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "5)" "File server" "(FILE)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "6)" "User machine" "(USER)"
printf "${Yellow}%-4s ${Cyan}%-20s${ResetColor}\n\n"            "q)" "For Exit"
read -r choice
case $choice in
###############################

#########################################
# If Choice is : Name serveur one (NS1) #
1)
# Set machine name
var1="ns1"
# Infos
printf "${Green}%s ${Cyan}%s ${Green}%s${ResetColor}\n\n"       "Installation of" "Name serveur one (NS1)" "is starting..."
# Functions
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
#########################################

#########################################
# If Choice is : Name serveur two (NS2) #
2)
# Set machine name
var1="ns2"
# Infos
printf "${Green}%s ${Cyan}%s ${Green}%s${ResetColor}\n\n"       "Installation of" "Name serveur two (NS2)" "is starting..."
# Functions
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
# Set machine name
var1="addcp"
# Infos
printf "${Green}%s ${Cyan}%s ${Green}%s${ResetColor}\n\n"       "Installation of" "Primary AD server (ADDCP)" "is starting..."
# Functions
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
ConfRSYNCSysVol
ConfNTPServer
GoReboot
;;


4) # Secondary AD server  (ADDCS)
# Set machine name
var1="addcs"
# Infos
printf "${Green}%s ${Cyan}%s ${Green}%s${ResetColor}\n\n"       "Installation of" "Secondary AD server (ADDCS)" "is starting..."
# Functions
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
ConfRSYNCSysVol
ConfNTPClient
GoReboot
;;

5) # File server          (FILE)
# Set machine name
var1="file"
# Infos
printf "${Green}%s ${Cyan}%s ${Green}%s${ResetColor}\n\n"       "Installation of" "File server (FILE)" "is starting..."
# Functions
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

