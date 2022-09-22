#/bin/bash
################################################################
#  ADDCP
################################################################
#
# Version 1.0 - 2020-09-28
#
# By Guillaume
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
# Fixation du nom de la machine #

var1="addcp"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "\e[1;34m\nInstallation du Serveur Samba4 AD DC Primaire (ADDCP)\n\e[1;30m"
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
#echo "\nNom de la machine (ex: ns1,ns2,addcp,addcs,fichiers) :\n"
#read var1
echo "\nAdresse IP de la machine (ex: 172.162.99.13) :\n"
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
#echo  "\nNom du dossier partage commun SMB :\n"
#read var11
echo  "\nMasque de sous reseau (ex: 255.255.0.0) :\n"
read var12
echo  "\nPasserelle du reseau (ex: 172.162.1.1) :\n"
read var13
echo  "\nInterface ethernet (ex: ens192 ou eth0) :\n"
read var14
#echo  "\nAdresse IP du serveur ADDCP (ex: 172.162.99.13) :\n"
#read var15
echo  "\nAdresse IP du serveur ADDCS (ex: 172.162.99.14) :\n"
read var16
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
#echo "Nom du dossier partage commun SMB : $var11"
echo "Masque de sous réseau : $var12"
echo "Passerelle du reseau : $var13"
echo "Interface ethernet : $var14"
#echo "Adresse IP du srv ADDCP : $var15"
echo "Adresse IP du srv ADDCS : $var16"
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
#adresse ip srv dns ADDCS
        dns-nameservers $var16
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


######################################################################
# Configuration du SSL via CERTBOT #

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

### debut script renew
echo "#!/bin/sh
SITE=$var1.$var0
#exemple SITE=ns1.gugus.ovh

# move to the correct let's encrypt directory
cd /etc/letsencrypt/live/\$SITE

# copy the files
cp cert.pem /etc/ssl/certs/\$SITE.cert.pem
cp fullchain.pem /etc/ssl/certs/\$SITE.fullchain.pem
cp privkey.pem /etc/ssl/private/\$SITE.privkey.pem

# adjust permissions of the private key
chown :ssl-cert /etc/ssl/private/\$SITE.privkey.pem
chmod 640 /etc/ssl/private/\$SITE.privkey.pem" > /usr/local/bin/renew.sh
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


######################################################################
# Configuration de Webmin #

apt install -y shared-mime-info perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python unzip zip

cd /tmp
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.962_all.deb
dpkg --install webmin_1.962_all.deb
rm -dfr webmin_1.962_all.deb

echo  "\e[1;32m\nConfiguration de Webmin 'OK'\n\e[1;30m"
echo  "\n\e[1;33mWebmin est accessible via \e[1;34mhttps://$var2:10000\e[1;30m"
echo  "\e[1;33mVotre login : \e[1;34mroot\e[1;30m"
echo  "\e[1;33mVotre pass : \e[1;34mmdp_root\n\e[1;30m"
sleep 3


######################################################################
# Configuration du SSL de Webmin #




######################################################################
# Configuration du serveur (ADDCP) SAMBA 4 AD DC Primaire #

echo  "\e[1;34m\nConfiguration du serveur $var18 SAMBA 4 AD DC Primaire\n\e[1;30m"

##############
# /etc/fstab #
##############

cp /etc/fstab  /etc/fstab.old
# recuperation de l'UUID de la partition principale
UUID=`cat /etc/fstab | grep ext4 | awk -F/ '{print $1}'`
# suppression de la ligne / ext4 partiton principale
sed -i".bak" '/ext4/d' /etc/fstab
# creation de la ligne / ext4 partition principale avec les nouveaux attributs
echo "$UUID    /    ext4    noatime,nodiratime,user_xattr,acl,errors=remount-ro    0    1" >> /etc/fstab

echo  "\e[1;32m\nConfiguration de FSTAB 'OK'\n\e[1;30m"

echo  "\e[1;31m\nPlusieurs fenetres vont apparaitre, tapez simplement sur 'entree' a chaque fois\n\e[1;30m"
sleep 20

# installation des paquets pour samba4 4 AD DC
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

##############################
# Creation du domaine samba4 #
##############################

# arret des anciens services
systemctl stop samba-ad-dc.service smbd.service nmbd.service winbind.service
systemctl disable samba-ad-dc.service smbd.service nmbd.service winbind.service

# deplacement de l'ancien fichier de conf Samba 4
mv /etc/samba/smb.conf /etc/samba/smb.conf.old1

# creation du domaine samba 4
samba-tool domain provision --use-rfc2307 --realm $var8 --domain $var7 --server-role dc --dns-backend BIND9_FLATFILE --adminpass $var17
#samba-tool domain provision --use-rfc2307 --realm $var8 --domain $var7 --server-role dc --dns-backend SAMBA_INTERNAL --adminpass $var17
#samba-tool domain provision --use-rfc2307 --realm $var8 --domain $var7 --server-role dc --dns-backend BIND9_DLZ --adminpass $var17

systemctl unmask samba-ad-dc.service
systemctl enable samba-ad-dc.service
systemctl start samba-ad-dc.service

echo  "\e[1;32m\nCreation du domaine $var7 'OK'\n\e[1;30m"

echo  "\e[1;34m\nVoici les informations sur votre domaine SAMBA 4 AD DC Primaire\n\e[1;33m"
samba-tool domain level show

echo "$var17" | kinit administrator@$var8
echo  "\e[1;34m\n\nVoici les informations de votre Kerberos\n\e[1;33m"
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

echo  "\e[1;32m\nConfiguration de /etc/samba/smb.conf 'OK'\n\e[1;30m"

####################
# NSS login system #
####################

# creer un repertoire personnel lors de la connexion
pam-auth-update --enable mkhomedir
echo  "\e[1;32m\nHome directory a la connexion 'OK'\n\e[1;30m"

# pour pouvoir authentifier et ouvrir une session ad sur le systeme local
cp /etc/nsswitch.conf /etc/nsswitch.conf.old
cat <<EOF > /etc/nsswitch.conf
# /etc/nsswitch.conf
#
# Example configuration of GNU Name Service Switch functionality.
# If you have the 'glibc-doc-reference' and 'info' packages installed, try:
# 'info libc "Name Service Switch"' for information about this file.

passwd:         compat winbind
group:          compat winbind
shadow:         compat
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

# les binaires Samba4 sont livres avec un demon winbind integre et active par defaut
# desactivation du demon winbind fourni par le package winbind a partir des referentiels debian officiels
systemctl disable winbind.service
systemctl stop winbind.service

echo  "\e[1;34m\n\nVoici les informations des groupes actuellement presents sur le domaine\n\e[1;33m"
wbinfo -g

echo  "\e[1;34m\n\nVoici la liste des utilisateurs actuellement presents sur le domaine\n\e[1;33m"
wbinfo -u
getent passwd | grep $var7

echo  "\e[1;34m\n\nVoici les parametres de mot de passe de votre domaine\n\e[1;33m"
samba-tool domain passwordsettings show
sleep 3

echo  "\e[1;32m\nConfiguration de SAMBA 4 AD DC Primaire 'OK'\n\e[1;30m"
sleep 3


######################################################################
# Replication SysVol via Rsync #
apt install -y rsync


######################################################################
# Configuration du serveur NTP #

apt install -y ntp ntpdate

cp /etc/ntp.conf /etc/ntp.conf.old
cat <<EOF > /etc/ntp.conf
# /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help

driftfile /var/lib/ntp/ntp.drift
ntpsigndsocket /var/lib/samba/ntp_signd/

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
restrict default kod nomodify notrap nopeer mssntp

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

# application des droits et reboot du service
chown root:ntp /var/lib/samba/ntp_signd/
chmod 750 /var/lib/samba/ntp_signd/
systemctl restart ntp

# verification du ntp
echo  "\e[1;33m\nVerification des pairs du serveur ntp\n\e[1;30m"
ntpq -p

echo  "\e[1;32m\nConfiguration du serveur NTP 'OK'\n\e[1;30m"
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
