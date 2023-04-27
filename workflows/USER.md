# Workflow for configuring a USER machine

## Banner, permissions and explanations
'BANNER'
'RootOrUser'
'HowTo'

## Base for all machines
1. 'SetDATA' Requests for machine parameters
> ip, ip, ip
2. 'ConfSHORTS' - Configuration of "ll & nn" hotkeys
3. 'ConfPATH' Configuring the sbin PATH
4. 'ConfSSH' Configuring SSH for root login
5. 'ConfNETWORK' Network Setup
6. 'ConfHOSTS' Configuring the HOSTS file
7. 'ConfHOSTNAME' Configuring the HOSTNAME
8. 'ConfSOURCES' Configuring the sources.list file
9. 'GoUPDATES' Launch of updates

## Specifics functions for this machine
1. JoinDOMAIN
> Samba4 AD DC domain join & FILE server connection
> - fstab
> - krb5.conf
> - smb.conf
> - Joining the machine to the domain
> - NSS login system
2. JoinFILE
Access Samba common volume share from Linux clients
3. ConfENVGra
Installing a graphical environment
4. ConfCOMMON
Installation of the "common" smb share shortcut on the desktop
5. ConfNTPClient
- Configuring the NTP Client
6. GoReboot
> Reboot
