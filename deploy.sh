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

################################################################################
# check sudo or root perms #
function RootOrUser {
Name=$(whoami)
printf "${Green}%s ${Cyan}%s${ResetColor}\n" "👋 '$Name'" "We will test if you are root or have sudo permissions"
# Check if the user is root
if [ "$Name" = "root" ]; then
printf "${Green}%s${ResetColor}\n" "'$Name' Is a good account"
else
        # If the sudo command is available, check if the user has sudo permissions
	if command -v sudo &> /dev/null; then
         	if ! sudo -l; then
                # If the user doesn't have sudo permissions, print an error message and exit with an error code
		printf "${Red}%s ${Cyan}%s${ResetColor}\n" "'$Name'" "Is not a sudoers account"
		printf "${Red}%s${ResetColor}\n" "Please logged in on a root or admin account and restart the script '$0'"
		exit 1
		else
                # If the user has sudo permissions, print a success message and prompt the user to switch to the root account
		printf "${Green}%s ${Cyan}%s${ResetColor}\n"  "'$Name'" "Is a sudoers account"
                printf "${Yellow}%s${ResetColor}\n" "Please logged in on your root account now, type your 'root' password"
                        if ! sudo -u root "$0"; then
                        # If the switch to the root account fails, exit with an error code
                        exit 1
                        fi
		fi
        else
       	# If the sudo command is not available, print an error message and exit with an error code
        printf "${Red}%s${ResetColor}\n" "'sudo' command not found. Please install 'sudo' to continue."
	exit 1
	fi
fi
# if sudo -u root "$0" is launched, this condition exiting properly the first script lauched by user
if [ "$Name" != "root" ]; then
exit 0
fi
}
################################################################################

################################################################################
# Requests for machine parameters #
function SetDATA {
printf "${Red}%s${ResetColor}\n"      "Please type answers in lowercase"

printf "${Red}%s${ResetColor}\n"        "Domain name (ex: domain.tld):"
read -r var0

printf "${Red}%s${ResetColor}\n"        "Machine IP address (ex: 192.168.1.201):"
read -r var2

#printf "${Red}%s${ResetColor}\n" "Active Directory server name:"
#read -r var3

if [ "$var1" = "ns2" ] || [ "$var1" = "addcp" ] || [ "$var1" = "addcs" ] || [ "$var1" = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}%s${ResetColor}\n"        "Primary DNS server (NS1) IP address (ex: 192.168.1.201):"
read -r var4
else
var4="$var2"
fi

if [ "$var1" = "ns1" ] || [ "$var1" = "addcp" ] || [ "$var1" = "addcs" ] || [ "$var1" = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}%s${ResetColor}\n"        "Secondary DNS server (NS2) IP address (ex: 192.168.1.202):"
read -r var5
else
var5="$var2"
fi

#printf "${Red}%s${ResetColor}\n" "Domain admin login:"
#read -r var6

# netbios domain name #
var7=$(echo "$var0" |cut -d. -f 1 | tr "[:lower:]" "[:upper:]")

# uppercase hostname #
var18=$(echo "$var1" | tr "[:lower:]" "[:upper:]")

# uppercase domain name #
var8=$(echo "$var0" | tr "[:lower:]" "[:upper:]")

#printf "${Red}%s${ResetColor}\n" "Samba server description:"
#read -r var9

#printf "${Red}%s${ResetColor}\n" "Domain user group name:"
#read -r var10

if [ "$var1" = "ns1" ] || [ "$var1" = "ns2" ] || [ "$var1" = "addcs" ] || [ "$var1" = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}%s${ResetColor}\n"        "Primary AD server (ADDCP) IP address (ex: 192.168.1.203)"
read -r var15
fi

if [ "$var1" = "ns1" ] || [ "$var1" = "ns2" ] || [ "$var1" = "addcp" ]; then
printf "${Red}%s${ResetColor}\n"        "Secondary AD server (ADDCS) IP address (ex: 192.168.1.204):"
read -r var16
fi

if [ "$var1" = "ns1" ] || [ "$var1" = "ns2" ]; then
printf "${Red}%s${ResetColor}\n"        "IP address of the FILE server (ex: 192.168.1.205):"
read -r var19
fi

printf "${Red}%s${ResetColor}\n"        "Ethernet interface (ex: eth0 or ens192):"
read -r var14

printf "${Red}%s${ResetColor}\n"        "Subnet mask (ex: 255.255.255.0):"
read -r var12

printf "${Red}%s${ResetColor}\n"        "Network gateway (ex: 192.168.1.1):"
read -r var13

if [ "$var1" = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}%s${ResetColor}\n"        "SMB common share folder name:"
read -r var11
fi

if [ "$var1" = "addcp" ] || [ "$var1" = "addcs" ] || [ "$var1" = "file" ] || [[ "$var1" =~ ^user-[$valid] ]]; then
printf "${Red}%s${ResetColor}\n"        "Password [administrator] kerberos 'uppercase, lowercase, number, symbol':"
read -r var17
fi

if [ "$var1" = "addcs" ] || [ "$var1" = "file" ]; then
printf "${Red}%s${ResetColor}\n"        "Password [root] of ADDCS server for 'SysVol replication':"
read -r var20
fi

# Print all data for verification #
printf "\n${Yellow}%s${ResetColor}\n"                   "Please check the following informations:"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Domain name:" "$var0"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Domain uppercase:" "$var8"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "NETBIOS name:" "$var7"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Machine name:" "$var1"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Hostname uppercase:" "$var18"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "@IP:" "$var2"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "@Primary DNS IP:" "$var4"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "@Secondary DNS IP:" "$var5"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "ADDCP srv IP address:" "$var15"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "ADDCS srv IP address:" "$var16"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "File srv IP address:" "$var19"
# printf "${Yellow}%s ${Green}%s${ResetColor}\n"        "AD server name:" "$var3"
# printf "${Yellow}%s ${Green}%s${ResetColor}\n"        "Domain admin login:" "$var6"
# printf "${Yellow}%s ${Green}%s${ResetColor}\n"        "Samba server description:" "$var9"
# printf "${Yellow}%s ${Green}%s${ResetColor}\n"        "Domain user group name:" "$var10"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Ethernet interface:" "$var14"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Subnet mask:" "$var12"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Network Gateway:" "$var13"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "SMB common share folder name:" "$var11"
printf "${Yellow}%s ${Green}%s${ResetColor}\n"          "Administrator password:" "$var17"
printf "${Yellow}%s ${Green}%s${ResetColor}\n\n"        "SysVol replication password:" "$var20"

# Export all variables for functions, from 0 to 20
for i in {0..20}; do
  export var"$i"
done

# Informations is correct ?! #
printf "${Yellow}%s${ResetColor}\n"     "Informations is correct ?! (Y/N)"
read -r info

if [[ "$info" =~ ^[yYoO] ]]; then
	printf "\n${Green}%s ${Cyan}%s${ResetColor}\n\n"    "OK" "Installation starts in 3 seconds"
	sleep 3
elif [[ "$info" =~ ^[nN] ]]; then
	printf "\n${Red}%s ${Cyan}%s${ResetColor}\n\n"      "OK" "Go to restart the script '$0'"
	./"$0"
		else
                printf "\n${Red}%s ${Yellow}%s${ResetColor}\n\n"      "INPUT ERROR" "Go to restart the script '$0'"
	        ./"$0"
fi
}
################################################################################

################################################################################
# Configuration of "ll & nn" alias #
function ConfSHORTS {
cp ~/.bashrc ~/.bashrc.old
cat <<EOF > ~/.bashrc
# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='\${debian_chroot:+(\$debian_chroot)}\h:\w\\$ '
# umask 022

# You may uncomment the following lines if you want 'ls' to be colorized:
 export LS_OPTIONS='--color=auto'
 eval "\$(dircolors)"
 alias ls='ls \$LS_OPTIONS'
 alias ll='ls \$LS_OPTIONS -ahl'
 alias l='ls \$LS_OPTIONS -lA'

# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# alias for nano
alias nn='nano'
EOF
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring shortcuts (ll & nn)"
sleep 3
}
################################################################################

################################################################################
# Configuring the sbin PATH #
function ConfPATH {
echo "# Configuring the sbin PATH" >> ~/.bashrc
echo "export PATH=/usr/local/sbin:/usr/sbin:/sbin:$PATH" >> ~/.bashrc
# bashrc reload
. ~/.bashrc
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring the sbin PATH"
sleep 3
}
################################################################################

################################################################################
# Configuring SSH for root login #
function ConfSSH {
apt -y install openssh-server
systemctl enable ssh
systemctl start ssh
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.old
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl restart ssh
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring SSH for root login"
sleep 3
}
################################################################################

################################################################################
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
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "NETWORK Setup"
sleep 3
}
################################################################################

################################################################################
# Configuring the HOSTS file #
function ConfHOSTS {
cp /etc/hosts  /etc/hosts.old   # Create a backup copy
echo "127.0.0.1       localhost
$var2     $var1.$var0     $var1

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts   # Add the specified entries
printf "${Green}%s ${Cyan}%s${ResetColor}\n"        "END OF" "Configuring the HOSTS file"   # Display a confirmation message
sleep 3   # Wait for 3 seconds
}
################################################################################

################################################################################
# Configuring the HOSTNAME #
function ConfHOSTNAME {
cp /etc/hostname  /etc/hostname.old
echo "$var1" > /etc/hostname
hostname "$var1"
# reboot the network service
/etc/init.d/networking restart
ifup "$var14"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring the HOSTNAME"
sleep 3
}
################################################################################

################################################################################
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
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring the sources.list file"
sleep 3
}
################################################################################

################################################################################
# Updates #
function GoUPDATES {
apt update && apt full-upgrade -y && apt autoremove -y
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Updates"
sleep 3
}
################################################################################

################################################################################
# Configuring SSL auto renew for Webmin through CERTBOT
function ConfSSL {
printf "${Red}%s${ResetColor}\n"     "Configuring SSL auto renew for Webmin through CERTBOT"
printf "${Red}%s${ResetColor}\n"     "Is this machine accessible from the outside via port 80? (Y/N)"

read -r cert
if [[ "$cert" =~ ^[yYoO] ]]; then
# Afficher le message en utilisant le formatage de chaîne pour les couleurs
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "OK" "Installation starts in 3 seconds"

# installation of certbot and generation of certificates
apt install -y certbot
certbot certonly --standalone -d "$var1"."$var0"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "OK" "Certbot installed and certificates generated"

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
printf "${Yellow}%s${ResetColor}\n"   "Your ORIGINAL CERTBOT SSL certificates and chain have been saved here:"
printf "${Cyan}%s${ResetColor}\n"     "/etc/letsencrypt/live/$var1.$var0/fullchain.pem"
printf "${Yellow}%s${ResetColor}\n"   "Your CERTBOT ORIGNAL SSL key file has been saved here:"
printf "${Cyan}%s${ResetColor}\n"     "/etc/letsencrypt/live/$var1.$var0/privkey.pem"
printf "${Red}%s${ResetColor}\n"      "ORIGINALS should not be used in applications or websites but only COPIES"
printf "${Red}%s${ResetColor}\n"      "Your duplicate certificates and WITH THE RIGHT RIGHTS are registered here:"
renew1=$(ls -ahl /etc/ssl/certs/$var1.$var0*) && printf "%s\n" "$renew1"
renew2=$(ls -ahl /etc/ssl/private/$var1.$var0*) && printf "%s\n" "$renew2"

printf "${Red}%s${ResetColor}\n"                "The renewal will be done automatically every 1st of the month at 3:15 a.m."
printf "${Yellow}%s${ResetColor}\n"             "Your log file of renew is '/var/log/renew-ssl-cerbot.log'"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring SSL auto-renewal script via CERTBOT"
sleep 3

elif [[ "$cert" =~ ^[nN] ]]; then
	printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "OK" "SSL auto renew for Webmin through CERTBOT was 'CANCELLED'"
        printf "${Cyan}%s${ResetColor}\n"               "Your Webmin only use the auto generated certificate by default"
        sleep 3
        else
        printf "${Red}%s ${Yellow}%s${ResetColor}\n"    "INPUT ERROR" "Go to restart the script '$0'"
	./"$0"
fi
}
################################################################################

################################################################################
# Configuring Webmin
function ConfWEBMIN {
# install the necessary packages for Webmin
apt install -y shared-mime-info perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip zip

# download & install latest version of Webmin
cd /tmp || exit 1
wget https://github.com/webmin/webmin/releases/download/2.021/webmin_2.021_all.deb
dpkg --install webmin_2.021_all.deb
rm -dfr webmin_2.021_all.deb

# print informations & sleep 3 secondes
printf "${Green}%s ${Cyan}%s${ResetColor}\n"            "END OF" "Configuring Webmin"
printf "${Yellow}%s ${Cyan}%s${ResetColor}\n"           "Webmin is accessible through :" "https://$var2:10000"
printf "${Yellow}%s ${Cyan}%s${ResetColor}\n"           "Your login name :" "root"
printf "${Yellow}%s ${Cyan}%s${ResetColor}\n"           "Your login pass :" "SameToMachinePass"
sleep 3
}
################################################################################

################################################################################
# Configuring BIND9 #
function ConfBIND9 {
#     Config for (NS1)    #
if [ "$var1" = "ns1" ]; then
ServerIP="$var5"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Bind9 configuration for server NS1"
fi
#     Config for (NS2)    #
if [ "$var1" = "ns2" ]; then
ServerIP="$var4"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Bind9 configuration for server NS2"
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
ipcut=$(echo "$var2" |cut -d. -f 1,2,3)
##### reversal of the cut of the ip of the srv, example 0.168.192
ipcutrev=$(echo "$var2" | awk -F. '{print $3"."$2"."$1}')

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
cat <<EOF > /var/lib/bind/"$var0".hosts
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
file.$var0.          IN      A     $var19
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
ipns1rev=$(echo "$var4" | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the secondary dns ip
ipns2rev=$(echo "$var5" | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the addcp srv ip
ipaddcprev=$(echo "$var15" | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the addcs srv ip
ipaddcsrev=$(echo "$var16" | awk -F. '{print $4"."$3"."$2"."$1}')
##### reversal of the ip of the srv files
ipfilerev=$(echo "$var19" | awk -F. '{print $4"."$3"."$2"."$1}')

##### /var/lib/bind/$ipcut.rev #####
cat <<EOF > /var/lib/bind/"$ipcut".rev
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
$ipfilerev.in-addr.arpa.      IN      PTR     file.$var0.
EOF
##### /var/lib/bind/$ipcut.rev #####

# restart service bind9
systemctl restart bind9

printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring BIND9"
sleep 3
}
################################################################################

################################################################################
# /etc/fstab #
function ConfFSTAB {
cp /etc/fstab  /etc/fstab.old
# get primary partition UUID
UUID=$(< /etc/fstab grep ext4 | awk -F/ '{print $1}')
# deleting the line /ext4 primary partition
sed -i".bak" '/ext4/d' /etc/fstab
# creating the line /ext4 primary partition with the new attributes
echo "$UUID    /    ext4    noatime,nodiratime,user_xattr,acl,errors=remount-ro    0    1" >> /etc/fstab
printf "${Green}%s ${Cyan}%s${ResetColor}\n"      "END OF" "Configure FSTAB"
sleep 3
}
################################################################################

################################################################################
# ConfS4 #
function ConfS4 {
# important notice
printf "${Red}%s${ResetColor}\n" "Several windows will appear, just hit 'ENTER' each time"
sleep 20

# install packages for samba4
apt install -y samba krb5-user krb5-config winbind libpam-winbind libnss-winbind acl
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Installation of Samba4 packages"
sleep 3
}
################################################################################

################################################################################
# /etc/krb5.conf #
function ConfKRB5 {
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
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring KERBEROS"
sleep 3
}
################################################################################

################################################################################
# Server configuration (ADDCP) SAMBA 4 AD DC Primary #
function ConfSAMBA4_AD_DCP {
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Configuring '$var18' SAMBA 4 AD DC Primary"
# stop old services
systemctl stop samba-ad-dc.service smbd.service nmbd.service winbind.service
systemctl disable samba-ad-dc.service smbd.service nmbd.service winbind.service
# moved old Samba 4 conf file
mv /etc/samba/smb.conf /etc/samba/smb.conf.old1
# creation of the samba 4 domain #
samba-tool domain provision --use-rfc2307 --realm "$var8" --domain "$var7" --server-role dc --dns-backend BIND9_FLATFILE --adminpass "$var17"
#samba-tool domain provision --use-rfc2307 --realm "$var8" --domain "$var7" --server-role dc --dns-backend SAMBA_INTERNAL --adminpass "$var17"
#samba-tool domain provision --use-rfc2307 --realm "$var8" --domain "$var7" --server-role dc --dns-backend BIND9_DLZ --adminpass "$var17"
# service management
systemctl unmask samba-ad-dc.service
systemctl enable samba-ad-dc.service
systemctl start samba-ad-dc.service
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Creation of the domain '$var7'"
# /etc/samba/smb.conf
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
# reboot services
systemctl restart samba-ad-dc.service
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring SAMBA 4 AD DC Primary '/etc/samba/smb.conf'"
sleep 3
}
################################################################################

################################################################################
# Server configuration (ADDCS) SAMBA 4 AD DC Secondary #
function ConfSAMBA4_AD_DCS {
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Configuring '$var18' SAMBA 4 AD DC Secondary"
# stop old services
systemctl stop samba-ad-dc.service smbd.service nmbd.service winbind.service
systemctl disable samba-ad-dc.service smbd.service nmbd.service winbind.service
# moved old Samba 4 conf file
mv /etc/samba/smb.conf /etc/samba/smb.conf.old1
# Joining the Samba4 AD DC from the ADDCP srv as a secondary domain controller #
samba-tool domain join "$var0" DC -U "administrator" --password "$var17"
# service management
systemctl unmask samba-ad-dc.service
systemctl enable samba-ad-dc.service
systemctl start samba-ad-dc.service
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Joigning domain '$var7'"
# /etc/samba/smb.conf
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
# reboot services
systemctl restart samba-ad-dc.service
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring SAMBA 4 AD DC Secondary '/etc/samba/smb.conf'"
sleep 3
}

################################################################################
# Server configuration (FILE) SERVER for SAMBA 4 #
function ConfSAMBA4_FILE_SRV {
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Configuring '$var18' SERVER"
# /etc/samba/smb.conf
cp /etc/samba/smb.conf /etc/samba/smb.conf.old1
cat <<EOF > /etc/samba/smb.conf
# Global parameters
[global]
  netbios name = $var18
  workgroup = $var7
  realm = $var8
  security = ADS
    dns forwarder = $var4,$var5

  # idmap config
  idmap config * : backend = tdb
  idmap config * : range = 50000-1000000

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

    # kerberos
    dedicated keytab file = /etc/krb5.keytab
    kerberos method = secrets and keytab

    # username map
    username map = /etc/samba/user.map

  # Rendre les file executables
  acl allow execute always = yes

# folders
    [netlogon]
      path = /var/lib/samba/sysvol/$var0/scripts
      read only = No

    [sysvol]
      path = /var/lib/samba/sysvol
      read only = No
# common folder
      [$var11]
	path = /$var11
	read only = no
EOF
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring FILE SERVER '/etc/samba/smb.conf'"
# mapper l'administrateur de domaine sur le compte root local
cat <<EOF > /etc/samba/user.map
!root = $var7\administrator
EOF
# reboot de samba 4
smbcontrol all reload-config
# Gestion des services
systemctl mask samba-ad-dc.service
systemctl stop samba-ad-dc.service
systemctl unmask smbd nmbd winbind
systemctl enable smbd nmbd winbind
# Jonction de la machine au domaine
net ads join -U administrator%"$var17"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Joigning domain '$var7'"
# restart services
systemctl restart smbd nmbd winbind
# Creation d'un répertoire de partage commun sur Samba4
echo "$var17" | kinit administrator@"$var8"
mkdir /"$var11"
chmod -R 775 /"$var11"
chown -R root:"domain users" /"$var11"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Creation du dossier de partage '$var11' sur Samba4"
sleep 3
}
################################################################################

################################################################################
# User configuration for SAMBA 4 #
function ConfSAMBA4_USER {
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Configuring '$var18' USER on SAMBA 4"
# /etc/samba/smb.conf
cp /etc/samba/smb.conf /etc/samba/smb.conf.old1
cat <<EOF > /etc/samba/smb.conf
# Global parameters
[global]
  netbios name = $var18
  workgroup = $var7
  realm = $var8
  security = ADS
    dns forwarder = $var4,$var5

  # idmap config
  idmap config * : backend = tdb
  idmap config * : range = 50000-1000000

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
EOF
# reboot de samba 4
smbcontrol all reload-config
# Gestion des services
systemctl mask samba-ad-dc.service
systemctl stop samba-ad-dc.service
systemctl mask smbd nmbd
systemctl stop smbd nmbd
systemctl unmask winbind
systemctl enable winbind
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring SAMBA 4 USER '/etc/samba/smb.conf'"
# Jonction de la machine au domaine
net ads join -U administrator%"$var17"
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Joigning domain '$var7'"
# restart services
systemctl restart winbind
}
################################################################################

################################################################################
# NSS login system #
function ConfNSS {
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
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring NSS"
sleep 3
}
################################################################################

################################################################################
# PAM login system #
function ConfPAM {
# creer un repertoire personnel lors de la connexion
pam-auth-update --enable mkhomedir
echo "session    required    pam_mkhomedir.so    skel=/etc/skel/    umask=0022" >> /etc/pam.d/common-account
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "PAM home directory has connection"
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
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "PAM remove 'try_authtok'"
sleep 3
}
################################################################################

################################################################################
# INFORMATIONS FOR SAMBA 4 AD #
function ADinfo {
# information about domain
printf "${Cyan}%s\n${Yellow}"           "Here is the informations about your SAMBA 4 AD DC domain: "
samba-tool domain level show
printf "%s${ResetColor}\n"
# information about password setting
printf "${Cyan}%s\n${Yellow}"           "Here are the password settings for your domain :"
samba-tool domain passwordsettings show
printf "%s${ResetColor}\n"
sleep 3
}
################################################################################

################################################################################
function Globalinfo {
# information about Kerberos
echo "$var17" | kinit administrator@"$var8"
printf "${Cyan}%s\n${Yellow}"           "Here is your Kerberos informations: "
klist
printf "%s${ResetColor}\n"
#
printf "${Cyan}%s\n${Yellow}"           "Here is the information of the groups currently present on the domain :"
wbinfo -g
printf "%s${ResetColor}\n"
#
printf "${Cyan}%s\n${Yellow}"           "Here is the list of users currently present on the domain :"
wbinfo -u
getent passwd | grep "$var7"
printf "%s${ResetColor}\n"
sleep 3
}
################################################################################

################################################################################
# SysVol replication from the first domain controller via Rsync #
function ConfRSYNCSysVol {
#     Config for (ADDCP)    #
if [ "$var1" = "addcp" ]; then
apt install -y rsync
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "SysVol replication 'SERVER'"
sleep 3
fi

#     Config for (ADDCS)    #
if [ "$var1" = "addcs" ]; then
printf "${Cyan}%s${ResetColor}\n"               "SysVol 'CLIENT' replication being configured..."

# installation des paquets
apt install -y rsync sshpass

# generation d'une cle ssh
ssh-keygen -t rsa -f /root/.ssh/rsa_SysVol -q -P ""

# copie de la cle sur le serveur ADDCP
sshpass -p "$var20" ssh-copy-id -i /root/.ssh/rsa_SysVol root@addcp -f

# test de replication
sshpass -p "$var20" rsync -XAavz --chmod=775 --delete-after --progress --stats -e "ssh -o StrictHostKeyChecking=no" root@addcp:/var/lib/samba/sysvol/ /var/lib/samba/sysvol/

# stockage du pass pour syncro cron
echo "$var20" > /root/.ssh/SysVol_pass
chmod 600 /root/.ssh/SysVol_pass

# ajout d'une tache automatique cron toutes les 5 minutes
croncmd2="sshpass -f /root/.ssh/SysVol_pass rsync -XAavz --chmod=775 --delete-after --progress --stats root@addcp:/var/lib/samba/sysvol/ /var/lib/samba/sysvol/ > /var/log/sysvol-replication.log 2>&1"
cronjob2="*/5 * * * * $croncmd2"
( crontab -l | grep -v -F "$croncmd2" ; echo "$cronjob2" ) | crontab -

printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring SysVol Replication 'CLIENT'"
sleep 3
fi
}
################################################################################

################################################################################
# Acceder au volume partage commun Samba a partir des clients Linux  #
function ConfCOMMON {
# installation des paquets
apt install -y smbclient cifs-utils

# les infos du serveur de partage de file
printf "${Cyan}%s\n${Yellow}"           "Here is the file sharing server info :"
smbclient -L \file -U administrator%"$var17"
printf "%s${ResetColor}\n\n"

# creation des dossiers et droits
mkdir /mnt/"$var11"
chmod 2770 /mnt/"$var11"
chown root:"domain users" /mnt/"$var11"
# 
mkdir /root/.samba
echo "username=administrator
password=$var17" > /root/.samba/"$var11"_pass
chmod 600 /root/.samba/"$var11"_pass

# fstab insertion
cp /etc/fstab  /etc/fstab.old2
echo "//file/$var11   /mnt/$var11   cifs   auto,x-systemd.automount,credentials=/root/.samba/""$var11""_pass,iocharset=utf8,file_mode=0770,dir_mode=0770,gid=50003   0   0" >> /etc/fstab
printf "${Green}%s ${Cyan}%s${ResetColor}\n" "END OF" "Creation of folders and rights & fstab automount"

# creation du raccourcis partage smb "common" sur le Bureau pour chaque utilisateur & application des droits
# french version
mkdir /etc/skel/Bureau
ln -s /mnt/"$var11" /etc/skel/Bureau/"$var11"
chmod 2770 /etc/skel/Bureau/"$var11"
chown root:"domain users" /etc/skel/Bureau/"$var11"
# english version
mkdir /etc/skel/Desktop
ln -s /mnt/"$var11" /etc/skel/Desktop/"$var11"
chmod 2770 /etc/skel/Desktop/"$var11"
chown root:"domain users" /etc/skel/Desktop/"$var11"
printf "${Green}%s ${Cyan}%s${ResetColor}\n" "END OF" "Acceder au partage SMB '$var11' a partir du bureau"
sleep 3
}
################################################################################

################################################################################
# Installation d'un environnement graphique #
function ConfENVGra {
# menu
printf "${Red}%s${ResetColor}\n"                                "Which graphical environment do you want to install :"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "1)" "KDE Plasma"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "2)" "GNOME"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "3)" "Xfce"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "n)" "I don't want a graphical environment"
read -r envgra
case $envgra in
#
1)
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Configuring KDE Plasma environment"
sleep 2
apt install -y kde-plasma-desktop
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring KDE Plasma environment"
;;
#
2)
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Configuring GNOME environment"
sleep 2
apt install -y gnome
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring GNOME environment"
;;
#
3)
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Configuring XFCE environment"
sleep 2
apt install -y xfce4
printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring XFCE environment"
;;
#
*)
printf "${Green}%s${ResetColor}\n"  "No graphical environment"
sleep 2
;;
esac
sleep 3
}
################################################################################

################################################################################
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
printf "${Cyan}%s\n${Yellow}"   "Checking NTP peers :"
ntpq -p
printf "%s${ResetColor}\n"

printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "NTP 'SERVER' configuration"
sleep 3
}
################################################################################

################################################################################
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
printf "${Cyan}%s\n${Yellow}"   "Checking NTP peers :"
ntpq -p
printf "%s${ResetColor}\n"

printf "${Cyan}%s\n${Yellow}"   "Synchronization with NTP server of domain '$var0'"
ntpdate -bu "$var0"
printf "%s${ResetColor}\n"

# ajout d'une tache automatique cron toutes les jours a 23hx pour la syncro de l'heure avec le domaine
chiffre=$(awk -v min=1 -v max=59 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')
croncmd3="/usr/sbin/ntpdate -bu $var0 > /var/log/ntp.log 2>&1"
cronjob3="*/$chiffre 23 * * * $croncmd3"
( crontab -l | grep -v -F "$croncmd3" ; echo "$cronjob3" ) | crontab -

printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "END OF" "Configuring the NTP 'CLIENT'"
sleep 3
}
################################################################################

################################################################################
# Reboot #
function GoReboot {
printf "${Red}%s${ResetColor}\n" "Your server will restart in 5 seconds ....."
sleep 1
printf "${Red}%s${ResetColor}\n" "Your server will restart in 4 seconds ...."
sleep 1
printf "${Red}%s${ResetColor}\n" "Your server will restart in 3 seconds ..."
sleep 1
printf "${Red}%s${ResetColor}\n" "Your server will restart in 2 seconds .."
sleep 1
printf "${Red}%s${ResetColor}\n" "Your server will restart in 1 seconds ."
sleep 1
systemctl reboot
}

################################################################################
################################################################
############################################
#  MAIN SCRIPT START HERE
############################################
################################################################
################################################################################
# Banners 
BANNER
#
RootOrUser
#
HowTo
############################################
# menu that prompts the user to choose     #
# which server or user they want to deploy #
printf "${Red}%s${ResetColor}\n"                                "Which server/user do you want to deploy :"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "1)" "Name serveur one" "(NS1)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "2)" "Name serveur two" "(NS2)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "3)" "Primary AD server" "(ADDCP)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "4)" "Secondary AD server" "(ADDCS)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "5)" "File server" "(FILE)"
printf "${Yellow}%-4s ${Cyan}%-20s %s${ResetColor}\n"           "6)" "User machine" "(USER)"
printf "${Yellow}%-4s ${Cyan}%-20s${ResetColor}\n\n"            "q)" "For Exit"
read -r choice
case $choice in
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
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
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
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
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
# If Choice is : Primary AD server (ADDCP)  #
3)
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
#
ConfFSTAB
ConfS4
ConfKRB5
#
ConfSAMBA4_AD_DCP
#
ConfNSS
ConfPAM
#
ADinfo
Globalinfo
ConfRSYNCSysVol
#
ConfNTPServer
GoReboot
;;
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
# If Choice is : Secondary AD server (ADDCS)  #
4)
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
#
ConfFSTAB
ConfS4
ConfKRB5
#
ConfSAMBA4_AD_DCS
#
ConfNSS
ConfPAM
#
ADinfo
Globalinfo
ConfRSYNCSysVol
ConfNTPClient
GoReboot
;;
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
# If Choice is :  # File server (FILE)  #
5)
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
#
ConfFSTAB
ConfS4
ConfKRB5
#
ConfSAMBA4_FILE_SRV
#
ConfNSS
ConfPAM
#
Globalinfo
ConfNTPClient
GoReboot
;;
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
# If Choice is : User machine (USER)  #
6)
# Set machine name
printf "${Red}%s${ResetColor}\n"        "Name of the machine (ex: Machine123) in a single block without spaces or symbols :"
read -r var1
# Check the input value contains the alphabet and number only
valid='[:alnum:]'
while [[ "$var1" =~ [^$valid] ]]; do
printf "${Red}%s${ResetColor}\n"        "Enter a machine Name with contains alphabet and number only :"
read -r var1
done
# set definitive Name of machine
var1="user-$var1"
printf "${Cyan}%s ${Green}%s${ResetColor}\n"    "Your machine Name is :" "$var1"
# Base for all machines
SetDATA
ConfSHORTS
ConfPATH
ConfSSH
ConfNETWORK
ConfHOSTS
ConfHOSTNAME
ConfSOURCES
GoUPDATES
# Specifics functions for this machine
#
ConfFSTAB
ConfS4
ConfKRB5
#
ConfSAMBA4_USER
#
ConfNSS
ConfPAM
#
Globalinfo
ConfCOMMON
ConfENVGra
ConfNTPClient
GoReboot
;;
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
# If Choice is :   Exit
q)
exit 0
;;
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
# If Choice is :   Other caracters
*)
printf "${Green}%s ${Cyan}%s${ResetColor}\n" "INPUT ERROR" "Please restart the script '$0'"
exit 1
;;
esac
################################################################################
################################################################
############################################
#  MAIN SCRIPT STOP HERE
############################################
################################################################
################################################################################




# enable ssh login for root user ?! #
printf "${Red}%s${ResetColor}\n"        "Do you want to enable ssh login for root user ?! (Y/N)"
read -r sshroot
if [[ "$sshroot" =~ ^[yYoO] ]]; then
	printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "START" "Enabling ssh login for root user"
	ConfSSH
else
	printf "${Green}%s ${Cyan}%s${ResetColor}\n"    "OK" "Not enabling ssh login for root user"
	apt -y install openssh-server
	systemctl enable ssh
	systemctl start ssh
fi



