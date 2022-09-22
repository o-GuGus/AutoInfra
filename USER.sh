#/bin/bash
################################################################
#  USER
################################################################
#
# Version 1.0 - 2021-01-13
#
# By Guillaume 321
#
################################################################
################################################################


######################################################################
# imposition d'ecriture en noir #
echo "\e[30m"
# textes
# default # echo "\e[39m"
# noir # echo "\e[30m"
# rouge # echo "\e[31m"
# vert # echo "\e[32m"
# jaune # echo "\e[33m"
# bleu # echo "\e[34m"


######################################################################
# Presentation #

echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "\e[1;34m\nInstallation d'une Machine integree au domaine (USER)\n\e[1;30m"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"


######################################################################
# Questions #

echo "\n\e[1;31mVeuillez taper les reponses en minuscule\n"

# texte vert bold
echo "\e[1;32m"
#
echo "\nNom du domaine (ex: gugus.ovh) :\n"
read var0
echo "\nNom de la machine (ex: IMac-GuillaumeG) 'd'un seul bloc sans espaces ni symboles (tiret '-' possible)' :\n"
read var1
echo "\nAdresse IP de la machine (ex: 172.162.100.1) :\n"
read var2
#echo "\nNom du serveur Active Directory :\n"
#read var3
echo "\nAdresse IP du serveur DNS Primaire (ns1) (ex: 172.162.99.11) :\n"
read var4
echo "\nAdresse IP du serveur DNS Secondaire (ns2) (ex: 172.162.99.12) :\n"
read var5
#echo  "\nLogin administrateur du domaine :\n"
#read var6
#echo  "\nDescription du serveur Samba :\n"
#read var9
#echo "Nom du groupe utilisateur du domaine :\n"
#read var10
echo  "\nNom du dossier partage commun SMB :\n"
read var11
echo  "\nMasque de sous reseau (ex: 255.255.0.0) :\n"
read var12
echo  "\nPasserelle du reseau (ex: 172.162.1.1) :\n"
read var13
echo  "\nInterface ethernet (ex: ens192 ou eth0) :\n"
read var14
echo  "\nAdresse IP du serveur ADDCP (ex: 172.162.99.13) :\n"
read var15
#echo  "\nAdresse IP du serveur ADDCS (ex: 172.162.99.14) :\n"
#read var16
echo  "\nMot de passe [administrator] kerberos 'majuscule,minuscule,chiffre,symbole' :\n"
read var17
#echo "\nNAdresse IP du serveur FICHIERS (ex: 172.162.99.15) :\n"
#read var19
#echo  "\nMot de passe 'root' pour le serveur 'ADDCP' \n"
#read var20

# Nom netbios #
var7=`echo $var0 |cut -d. -f 1`
var7=`echo "$var7" | tr "[:lower:]" "[:upper:]"`

# Nom de domaine majuscule #
var8=`echo "$var0" | tr "[:lower:]" "[:upper:]"`

# Hostname en majuscule #
var18=`echo "$var1" | tr "[:lower:]" "[:upper:]"`

echo "\n\e[1;31mVeuillez controler les informations suivantes :\n"

# texte jaune bold
echo "\e[1;33m"
#
echo "Domaine : $var0"
echo "Hostname : $var1"
echo "@IP : $var2"
#echo "nom du serveur AD : $var3"
echo "@IP DNS primaire : $var4"
echo "@IP DNS secondaire : $var5"
#echo "Login admin du domaine : $var6"
echo "Nom NETBIOS : $var7"
echo "Domaine en majuscule : $var8"
#echo "Description du serveur Samba : $var9"
#echo "Nom du groupe utilisateur du domaine : $var10"
echo "Nom du dossier partage commun SMB : $var11"
echo "Masque de sous réseau : $var12"
echo "Passerelle du reseau : $var13"
echo "Interface ethernet : $var14"
echo "Adresse IP du srv ADDCP : $var15"
#echo "Adresse IP du srv ADDCS : $var16"
echo "Mot de passe administrator : $var17"
echo "Hostname en majuscule : $var18"
#echo "Adresse IP du srv FICHIERS : $var19"
#echo "Mot de passe root ADDCP : $var20"

# Les informations sont elles correctes #
echo  "\n\n\e[1;31mLes information saisies sont elles correctes ? (Y/N)\n"
read infos
case $infos in
  [yYoO]*) echo "\n\e[1;32m'OK' \e[1;30mL’installation commence dans 3 secondes\n\e[30m"
 sleep 3;;
  [nN]*) echo "\n\e[1;31mVeuillez relancer le script \e[34m'$0'\n\e[30m"
 exit 0;;
  *) echo "\n\e[1;31m'ERREUR de saisie' \e[1;30mVeuillez relancer le script \e[34m'$0'\n\e[30m"
 exit 1;;
esac


######################################################################
# Configuration des raccourcis "ll & nn" #

cp /root/.bashrc /root/.bashrc.old

cat <<EOF > /root/.bashrc
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
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
# alias ll='ls -ahl'
alias nn='nano'
EOF

echo  "\e[1;32m\nConfiguration des raccourcis (ll & nn) 'OK'\n\e[1;30m"
sleep 3


######################################################################
# Configuration du PATH sbin #

echo "# Configuration du PATH sbin" >> /root/.bashrc
echo "export PATH=/usr/local/sbin:/usr/sbin:/sbin:$PATH" >> /root/.bashrc
# rechargement du bashrc
. ~/.bashrc

echo  "\e[1;32m\nConfiguration du PATH sbin 'OK'\n\e[1;30m"
sleep 3


######################################################################
# Configuration du SSH pour connexion en root #

apt -y install openssh-server
systemctl enable ssh
systemctl start ssh

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.old

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

echo  "\e[1;32m\nConfiguration du SSH 'OK'\n\e[1;30m"
sleep 3


######################################################################
# Configuration du RESEAU #

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
#iface $var14 inet dhcp
iface $var14 inet static
#adresse ip machine
        address $var2
        netmask $var12
        gateway $var13
#adresse ip srv dns ADDCP
        #dns-nameservers $var15
#adresse ip srv dns primaire
        dns-nameservers $var4
#adresse ip srv dns secondaire
        dns-nameservers $var5
        dns-search $var0" > /etc/network/interfaces

echo  "\e[1;32m\nConfiguration du RESEAU 'OK'\n\e[1;30m"
sleep 3


######################################################################
# Configuration du fichier HOSTS #

cp /etc/hosts  /etc/hosts.old

echo "127.0.0.1       localhost
$var2     $var1.$var0     $var1

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters" > /etc/hosts

echo  "\e[1;32m\nConfiguration du fichier HOSTS 'OK'\n\e[1;30m"
sleep 3


######################################################################
# Configuration du HOSTNAME #

cp /etc/hostname  /etc/hostname.old
echo "$var1" > /etc/hostname
hostname $var1

echo  "\e[1;32m\nConfiguration du HOSTNAME 'OK'\n\e[1;30m"

# reboot du service reseau
/etc/init.d/networking restart
ifup $var14

sleep 3


######################################################################
# Configuration du fichier sources.list #

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

echo  "\e[1;32m\nConfiguration du fichier sources.list 'OK'\n\e[1;30m"
sleep 3


#####################################################################
# Mises a jour #

apt update
apt dist-upgrade -y

echo  "\e[1;32m\nMise a Jour du Serveur 'OK'\n\e[1;30m"
sleep 3


#############################################################################
# Jonction au domaine Samba4 AD DC & Connexion au serveur de FICHIERS #

echo  "\e[1;34m\nJonction au domaine Samba4 AD DC & Connexion au serveur de FICHIERS\n\e[1;30m"

##############
# /etc/fstab #
##############

cp /etc/fstab  /etc/fstab.old1
# recuperation de l'UUID de la partition principale
UUID=`cat /etc/fstab | grep ext4 | awk -F/ '{print $1}'`
# suppression de la ligne / ext4 partiton principale
sed -i".bak" '/ext4/d' /etc/fstab
# creation de la ligne / ext4 partition principale avec les nouveaux attributs
echo "$UUID    /    ext4    noatime,nodiratime,user_xattr,acl,errors=remount-ro    0    1" >> /etc/fstab

echo  "\e[1;32m\nConfiguration de FSTAB 'OK'\n\e[1;30m"

echo  "\e[1;31m\nPlusieurs fenetres vont apparaitre, tapez simplement sur 'entree' a chaque fois\n\e[1;30m"
sleep 20

# installation des paquets pour samba4
apt install -y samba krb5-user krb5-config winbind libpam-winbind libnss-winbind acl

echo  "\e[1;32m\nInstallation des paquets 'OK'\n\e[1;30m"

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

echo  "\e[1;32m\nConfiguration KERBEROS 'OK'\n\e[1;30m"

################################################
# Configuration de SAMBA 4 /etc/samba/smb.conf #
################################################

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

echo  "\e[1;32m\nConfiguration de /etc/samba/smb.conf 'OK'\n\e[1;33m"

#####################################
# Jonction de la machine au domaine #
#####################################

# Jonction de la machine au domaine
net ads join -U administrator%$var17
echo  "\e[1;32m\nJonction au domaine $var7 'OK'\n\e[1;33m"

echo "$var17" | kinit administrator@$var8
echo  "\e[1;34m\n\nVoici les informations de votre Kerberos\n\e[1;33m"
klist

systemctl restart winbind

####################
# NSS login system #
####################

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
echo  "\e[1;32m\nConfiguration du NSS 'OK'\n\e[1;30m"

# creer automatiquement le (home directory) pour les utilisateurs de domaine authentifies
pam-auth-update --enable mkhomedir
echo "session    required    pam_mkhomedir.so    skel=/etc/skel/    umask=0022" >> /etc/pam.d/common-account
echo  "\e[1;32m\nHome directory a la connexion 'OK'\n\e[1;30m"

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
echo  "\e[1;32m\nSuppression de try_authtok 'OK'\n\e[1;30m"

echo  "\e[1;34m\n\nVoici les informations des groupes actuellement presents sur le domaine\n\e[1;33m"
wbinfo -g

echo  "\e[1;34m\n\nVoici la liste des utilisateurs actuellement presents sur le domaine\n\e[1;33m"
wbinfo -u
getent passwd | grep $var7
echo "\e[30m"

######################################################################
# Acceder au volume partage commun Samba a partir des clients Linux  #
######################################################################

# installation des paquets
apt install -y smbclient cifs-utils

# les infos du serveur de partage de fichiers
echo  "\e[1;34m\n\nVoici les infos du serveur de partage de fichiers\n\e[1;33m"
smbclient -L \fichiers -U administrator%$var17
echo "\e[30m"

# creation des dossiers et droits
mkdir /mnt/$var11
chmod 2770 /mnt/$var11
chown root:"domain users" /mnt/$var11

mkdir /root/.samba
echo "username=administrator
password=$var17" > /root/.samba/"$var11"_pass
chmod 600 /root/.samba/"$var11"_pass

# fstab insertion
cp /etc/fstab  /etc/fstab.old2
echo "//fichiers/$var11   /mnt/$var11   cifs   auto,x-systemd.automount,credentials=/root/.samba/"$var11"_pass,iocharset=utf8,file_mode=0770,dir_mode=0770,gid=50003   0   0" >> /etc/fstab

echo  "\e[1;32m\nAcceder au volume partage '$var11' Samba4 a partir des clients Linux 'OK'\n\e[1;30m"
sleep 3


#####################################################################
# Installation d'un environnement graphique #

echo  "\e[1;31m\nQuel environnement graphique voulez-vous installer :\n"
echo  "1) KDE Plasma"
echo  "2) GNOME"
echo  "3) Xfce"
echo  "a) AUCUN"

read envgra
case $envgra in

1)
echo  "\e[1;34m\nInstallation de l'environnement KDE Plasma\e[1;30m"
sleep 2
apt install -y kde-plasma-desktop
echo "\n\e[1;32m'OK' \e[1;30mL’installation de l'environnement graphique est terminee\n\e[30m"
;;

2)
echo  "\e[1;34m\nInstallation de l'environnement GNOME\e[1;30m"
sleep 2
apt install -y gnome
echo "\n\e[1;32m'OK' \e[1;30mL’installation de l'environnement graphique est terminee\n\e[30m"
;;

3)
echo  "\e[1;34m\nInstallation de l'environnement Xfce\e[1;30m"
sleep 2
apt install -y xfce4
echo "\n\e[1;32m'OK' \e[1;30mL’installation de l'environnement graphique est terminee\n\e[30m"
;;

*)
echo  "\e[1;34m\nPas d'environnement graphique\e[1;30m"
sleep 2
;;

esac


#####################################################################
# Installation du raccourcis partage "commun" smb sur le bureau #

# creation du raccourcis sur le Bureau pour chaque utilisateur & application des droits
mkdir /etc/skel/Bureau
ln -s /mnt/$var11 /etc/skel/Bureau/$var11
chmod 2770 /etc/skel/Bureau/$var11
chown root:"domain users" /etc/skel/Bureau/$var11


######################################################################
# Configuration du Client NTP #

apt install -y ntp ntpdate

cp /etc/ntp.conf /etc/ntp.conf.old
cat <<EOF > /etc/ntp.conf
# /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help

driftfile /var/lib/ntp/ntp.drift

# Leap seconds definition provided by tzdata
leapfile /usr/share/zoneinfo/leap-seconds.list

# Enable this if you want statistics to be logged.
#statsdir /var/log/ntpstats/

statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable


# You do need to talk to an NTP server or two (or three).
#server ntp.your-provider.example

# pool.ntp.org maps to about 1000 low-stratum NTP servers.  Your server will
# pick a different set every time it starts up.  Please consider joining the
# pool: <http://www.pool.ntp.org/join.html>

server $var15
pool $var0

pool 0.debian.pool.ntp.org iburst
pool 1.debian.pool.ntp.org iburst
pool 2.debian.pool.ntp.org iburst
pool 3.debian.pool.ntp.org iburst

# Access control configuration; see /usr/share/doc/ntp-doc/html/accopt.html for
# details.  The web page <http://support.ntp.org/bin/view/Support/AccessRestrictions>
# might also be helpful.
#
# Note that "restrict" applies to both servers and clients, so a configuration
# that might be intended to block requests from certain clients could also end
# up blocking replies from your own upstream servers.

# By default, exchange time with everybody, but don't allow configuration.
restrict -4 default kod notrap nomodify nopeer noquery limited
restrict -6 default kod notrap nomodify nopeer noquery limited

# Local users may interrogate the ntp server more closely.
restrict 127.0.0.1
restrict ::1

# Needed for adding pool entries
restrict source notrap nomodify noquery mssntp

# Clients from this (example!) subnet have unlimited access, but only if
# cryptographically authenticated.
#restrict 192.168.123.0 mask 255.255.255.0 notrust


# If you want to provide time to your local subnet, change the next line.
# (Again, the address is an example only.)
#broadcast 192.168.123.255

# If you want to listen to time broadcasts on your local subnet, de-comment the
# next lines.  Please do this only if you trust everybody on the network!
#disable auth
#broadcastclient
EOF

systemctl restart ntp

# verification du ntp
echo  "\e[1;33m\nVerification des pairs du Client NTP\n\e[1;30m"
ntpq -p

echo  "\e[1;33m\nSynchronisation avec le serveur NTP du domaine $var0\n\e[1;30m"
ntpdate -bu $var0

# ajout d'une tache automatique cron toutes les jours a 23hx pour la syncro de l'heure avec le domaine
chiffre=`awk -v min=1 -v max=59 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'`
croncmd3="/usr/sbin/ntpdate -bu $var0 > /var/log/ntp.log 2>&1"
cronjob3="*/$chiffre 23 * * * $croncmd3"
( crontab -l | grep -v -F "$croncmd3" ; echo "$cronjob3" ) | crontab -

echo  "\e[1;32m\nConfiguration du Client NTP 'OK'\n\e[1;30m"
sleep 3


#####################################################################
# Reboot #

echo  "\e[1;31m\nVotre serveur va redemmarrer dans 5 secondes .....\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 4 secondes ....\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 3 secondes ...\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 2 secondes ..\n"
sleep 1
echo  "\nVotre serveur va redemmarrer dans 1 secondes .\n\e[1;30m"
sleep 1
systemctl reboot
