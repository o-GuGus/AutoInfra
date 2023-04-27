# use ad samba4


> 1. In order to create a user on AD, use the following command:
~~~shell
samba-tool user create your_domain_user
~~~

> 2. To add a user with several important fields required by AD, use the following syntax:
~~~shell
samba-tool user add -h
samba-tool user add your_domain_user --given-name=your_name --surname=your_username --mail-address=your_domain_user@domain.tld --login-shell=/bin/bash
~~~

> 3. A list of all users in the Samba AD domain can be obtained by running the following command:
~~~shell
samba-tool user list
~~~

> 4. To delete a Samba AD domain user, use the syntax below:
~~~shell
samba-tool user delete your_domain_user
~~~

> 5. Reset the password of a samba domain user by running the command below:
~~~shell
samba-tool user setpassword your_domain_user
~~~

> 6. To disable or enable a samba AD user account, use the command below:
~~~shell
samba-tool user disable your_domain_user
samba-tool user enable your_domain_user
~~~

> 7. Similarly, samba groups can be managed with the following command syntax:
~~~shell
samba-tool group add –h
samba-toolgroup add your_domain_group
~~~

> 8. Delete samba domain group by running below command:
~~~shell
samba-tool group delete your_domain_group
~~~

> 9. To view all Samba domain groups, run the following command:
~~~shell
samba-tool group list
~~~

> 10. To list all samba domain members in a specific group, use the command:
~~~shell
samba-tool group listmembers "your_domain group"
~~~

> 11. Adding/removing a member of a samba domain group can be done by running one of the following commands:
~~~shell
samba-tool group addmembers your_domain_group your_domain_user
samba-tool group remove members your_domain_group your_domain_user
~~~

> 12. To check your samba domain password settings, use the command below:
~~~shell
samba-tool domain passwordsettings show
~~~

> 13. In order to change the samba domain password policy, such as password complexity level, password aging, length, number of old passwords to remember and others security features required for a domain controller, use the command below:
~~~shell
samba-tool domain passwordsettings -h
~~~

> 14. The following commands illustrate how to query AD users and groups using wbinfo:
~~~shell
wbinfo -g
wbinfo -u
wbinfo -i your_domain_user
~~~

> 15. In addition to the wbinfo utility, you can also use the getent command line utility to query the Active Directory database from the name service switch libraries which are represented in the /etc/nsswitch file. conf.
Run the getent command through a grep filter to restrict results to only your AD domain user or group database:
~~~shell
getentpasswd | grep DOMAIN
getent group | grep DOMAIN
~~~