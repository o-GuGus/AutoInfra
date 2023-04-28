
#####################################################################
# Access the Samba Shared Volume from Linux Clients #


######### a rajouter dans smb.conf ######### partout ? !

acl allow execute always = yes

#############


# test connexion
smbclient -L domain.tld -U% #ok
smbclient //file.domain.tld/common -U user #ok
systemctl restart samba-ad-dc.service


# montage de volume auto au demmarrage
mount //file/$var11 /mnt/$var11 -o username=administrator%$var17
mount //file/common /mnt/common -o username=toto%monpassword


###############TEST############

mkdir -p /srv/samba/Demo/

chown root:"Domain Admins" /srv/samba/Demo/
chmod 0770 /srv/samba/Demo/

smbcontrol all reload-config

chmod 2770 /srv/samba/Demo/
chown root:"Domain Users" /srv/samba/Demo/


net rpc rights grant "DOMAIN\administrator" SeDiskOperatorPrivilege -U "DOMAIN\administrator"
net rpc rights list privileges SeDiskOperatorPrivilege -U "DOMAIN\administrator"


###############TEST############


# prise en charge cifs
apt install smbfs


# tout monter fstab
mount -a 

# voir les file monté
mount 


