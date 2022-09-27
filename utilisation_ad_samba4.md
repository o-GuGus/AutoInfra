# utilisation ad samba4


> 1. Afin de créer un utilisateur sur AD, utilisez la commande suivante:
~~~shell
samba-tool user create your_domain_user
~~~

> 2. Pour ajouter un utilisateur avec plusieurs champs importants requis par AD, utilisez la syntaxe suivante:
~~~shell
samba-tool user add -h  
samba-tool user add your_domain_user --given-name=your_name --surname=your_username --mail-address=your_domain_user@gugus.ovh --login-shell=/bin/bash
~~~

> 3. Une liste de tous les utilisateurs du domaine Samba AD peut être obtenue en exécutant la commande suivante:
~~~shell
samba-tool user list
~~~

> 4. Pour supprimer un utilisateur de domaine Samba AD, utilisez la syntaxe ci-dessous:
~~~shell
samba-tool user delete your_domain_user
~~~

> 5. Réinitialisez le mot de passe d'un utilisateur de domaine samba en exécutant la commande ci-dessous:
~~~shell
samba-tool user setpassword your_domain_user
~~~

> 6. Pour désactiver ou activer un compte utilisateur samba AD, utilisez la commande ci-dessous:
~~~shell
samba-tool user disable your_domain_user
samba-tool user enable your_domain_user
~~~

> 7. De même, les groupes samba peuvent être gérés avec la syntaxe de commande suivante:
~~~shell
samba-tool group add –h  
samba-tool group add your_domain_group
~~~

> 8. Supprimez un groupe de domaines samba en exécutant la commande ci-dessous:
~~~shell
samba-tool group delete your_domain_group
~~~

> 9. Pour afficher tous les groupes de domaines Samba, exécutez la commande suivante:
~~~shell
samba-tool group list
~~~

> 10. Pour lister tous les membres du domaine samba dans un groupe spécifique, utilisez la commande:
~~~shell
samba-tool group listmembers "your_domain group"
~~~

> 11. L'ajout / la suppression d'un membre d'un groupe de domaine samba peut être effectué en exécutant l'une des commandes suivantes:
~~~shell
samba-tool group addmembers your_domain_group your_domain_user
samba-tool group remove members your_domain_group your_domain_user
~~~

> 12. Pour vérifier les paramètres de mot de passe de votre domaine samba, utilisez la commande ci-dessous:
~~~shell
samba-tool domain passwordsettings show
~~~

> 13. Afin de modifier la politique de mot de passe de domaine samba, comme le niveau de complexité du mot de passe, le vieillissement du mot de passe, la longueur, le nombre d'anciens mots de passe à retenir et d'autres fonctionnalités de sécurité requises pour un contrôleur de domaine, utilisez la commande ci-dessous:
~~~shell
samba-tool domain passwordsettings -h 
~~~

> 14. Les commandes suivantes illustrent comment interroger les utilisateurs et les groupes AD à l'aide de wbinfo:
~~~shell
wbinfo -g
wbinfo -u
wbinfo -i your_domain_user
~~~

> 15. Outre l'utilitaire wbinfo, vous pouvez également utiliser l'utilitaire de ligne de commande getent pour interroger la base de données Active Directory à partir des bibliothèques de commutateur de service de noms qui sont représentées dans le fichier /etc/nsswitch.conf.
Faites passer la commande getent à travers un filtre grep afin de restreindre les résultats concernant uniquement votre base de données d'utilisateurs ou de groupes de domaine AD:
~~~shell
getent passwd | grep GUGUS
getent group | grep GUGUS
~~~

