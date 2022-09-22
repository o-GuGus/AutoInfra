
#####################################################################
# Access the Samba Shared Volume from Linux Clients #


######### a rajouter dans smb.conf ######### partout ? !

acl allow execute always = yes

#############


# test connexion
smbclient -L gugus.ovh -U% #ok
smbclient //fichiers.gugus.ovh/commun -U moi2202 #ok
systemctl restart samba-ad-dc.service


# montage de volume auto au demmarrage
mount //fichiers/$var11 /mnt/$var11 -o username=administrator%$var17
mount //fichiers/commun /mnt/commun -o username=toto%monpassword


###############TEST############

mkdir -p /srv/samba/Demo/

chown root:"Domain Admins" /srv/samba/Demo/
chmod 0770 /srv/samba/Demo/

smbcontrol all reload-config

chmod 2770 /srv/samba/Demo/
chown root:"Domain Users" /srv/samba/Demo/


net rpc rights grant "GUGUS\administrator" SeDiskOperatorPrivilege -U "GUGUS\administrator"
net rpc rights list privileges SeDiskOperatorPrivilege -U "GUGUS\administrator"


###############TEST############


# prise en charge cifs
apt install smbfs


# tout monter fstab
mount -a 

# voir les fichiers monté
mount 


