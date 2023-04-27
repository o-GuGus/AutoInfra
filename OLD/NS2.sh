#!/bin/bash
################################################################
#  NS2
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

var1="ns2"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_"
echo "\e[1;34m\nInstallation du Serveur Name Serveur #2 (NS2)\n\e[1;30m"
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
#ead var1
echo "\nAdresse IP de la machine (ex: 172.162.99.12) :\n"
read var2
#echo "\nNom du serveur Active Directory :\n"
#read var3
echo "\nAdresse IP du serveur DNS Primaire (ns1) (ex: 172.162.99.11) :\n"
read var4
#echo "\nAdresse IP du serveur DNS Secondaire (ns2) (ex: 172.162.99.12) :\n"
#read var5
var5="$var2"
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
echo  "\nAdresse IP du serveur ADDCP (ex: 172.162.99.13) :\n"
read var15
echo  "\nAdresse IP du serveur ADDCS (ex: 172.162.99.14) :\n"
read var16
#echo  "\nMot de passe [administrator] kerberos 'majuscule,minuscule,chiffre,symbole' :\n"
#read var17
echo "\nNAdresse IP du serveur FICHIERS (ex: 172.162.99.15) :\n"
read var19
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
echo "Adresse IP du srv ADDCP : $var15"
echo "Adresse IP du srv ADDCS : $var16"
#echo "Mot de passe administrator : $var17"
echo "Hostname en majuscule : $var18"
echo "Adresse IP du srv FICHIERS : $var19"
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
# Configuration de BIND9 #


##########################
# Configuration de BIND9 #
#     Config pour NS2    #
##########################


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
server $var4 {
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


##### /etc/bind/named.conf.local #####
##### cut de l'ip du srv aux 3 premiers blocs, exemple 192.168.0
ipcut=`echo $var2 |cut -d. -f 1,2,3`
##### retournement du cut de l'ip du srv, exemple 0.168.192
ipcutrev=`echo $var2 | awk -F. '{print $3"."$2"."$1}'`
#########
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


##### /var/lib/bind/$ipcut.rev #####
##### retournement de l'ip du dns primaire
ipns1rev=`echo $var4 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### retournement de l'ip du dns secondaire
ipns2rev=`echo $var5 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### retournement de l'ip du srv addcp
ipaddcprev=`echo $var15 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### retournement de l'ip du srv addcs
ipaddcsrev=`echo $var16 | awk -F. '{print $4"."$3"."$2"."$1}'`
##### retournement de l'ip du srv fichiers
ipfichiersrev=`echo $var19 | awk -F. '{print $4"."$3"."$2"."$1}'`

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

systemctl restart bind9

echo  "\e[1;32m\nConfiguration de BIND9 'OK'\n\e[1;30m"
sleep 3


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
