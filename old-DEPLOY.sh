#!/bin/bash
clear
################################################################
#  Menu d'install et de configuration de SRV/USR pour Debian 10 Buster
#  Se connecter en root avant de lancer le script...
################################################################
#
# Version menu 1.0 du 2020-09-28
#
# By Guillaume
#


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
# Passage en root obligatoire #
chemin=`pwd`
tmp=`whoami`
if [ $tmp = "root" ];
then
        nom=`echo "$tmp"`
else
      echo "\n\e[1;32m'1' \e[1;31mMerci de taper votre mot de passe (root) :\e[30m"
echo "\n\e[1;32m'2' \e[1;31mVeuillez relancer le script \e[34m'$chemin/$0'\e[30m pour continer l'installation\n\e[30m"
        su root
fi

# si le mdp root n'est pas valide alors exit 0
if [ $tmp != "root" ];
then
  exit 0
else
  sleep 0
fi


################################################################
## Affichage menu
################################################################

echo  "\e[1;34m\nBienvenue dans le script de deploiement d'infra rapide by :\n"
echo  " ██████╗ ██╗   ██╗██╗██╗     ██╗      █████╗ ██╗   ██╗███╗   ███╗███████╗
██╔════╝ ██║   ██║██║██║     ██║     ██╔══██╗██║   ██║████╗ ████║██╔════╝
██║  ███╗██║   ██║██║██║     ██║     ███████║██║   ██║██╔████╔██║█████╗
██║   ██║██║   ██║██║██║     ██║     ██╔══██║██║   ██║██║╚██╔╝██║██╔══╝
╚██████╔╝╚██████╔╝██║███████╗███████╗██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗
 ╚═════╝  ╚═════╝ ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝\n\e[1;30m"

echo  "\e[1;31m\nCe script est prevu pour Debian 10 Buster"
echo  "\nIl faut avoir fixé les ip des machines avant de continuer \n\e[1;30m"

echo  "\e[1;32m\nVoici un exemple d'infra fonctionnelle :"
echo "
NS1                     192.168.200.11
NS2                     192.168.200.12
ADDCP                   192.168.200.13
ADDCS                   192.168.200.14
FICHIERS                192.168.200.15

USER1                   192.168.201.1
USER2                   192.168.201.2

MASQUE DE SS RESEAU     255.255.0.0 /16
PASSERELLE              192.168.1.1
\e[1;30m"

echo  "\e[1;33m\nQuel serveur/user voulez-vous deployer  :\n"
echo  "1) Name Serveur #1 (NS1)"
echo  "2) Name Serveur #2 (NS2)"
echo  "3) Serveur Samba4 AD DC Primaire (ADDCP)"
echo  "4) Serveur Samba4 AD DC Replique (ADDCS)"
echo  "5) Serveur de fichiers Samba4 (FICHIERS)"
echo  "6) Machine pour utilisateurs integree au domaine (USER)"
echo  "q) Pour quitter\n\e[1;30m"

read choix
case $choix in

################################################################
## Menu
################################################################

1)
if [ -d "/$nom/ScriptNS1" ]
then
cd /$nom/ScriptNS1
rm *
else
mkdir /$nom/ScriptNS1
cd /$nom/ScriptNS1
fi
echo  "\e[1;32m\nTelechargement du script\e[1;30m"
sleep 1
###
wget https://welcome.gugus.ovh/dl/NS1.sh
###
wget 10.132.20.70/dl/NS1.sh
###
if [ /$nom/ScriptNS1/NS1.sh ]
then
echo  "\e[1;32m\nExecution du script\e[1;30m"
sleep 1
sh /$nom/ScriptNS1/NS1.sh
else
echo  "\e[1;31m\nErreur veuillez verifier que vous etes bien connecte sur internet !\e[1;30m"
exit
fi
;;

2)
if [ -d "/$nom/ScriptNS2" ]
then
cd /$nom/ScriptNS2
rm *
else
mkdir /$nom/ScriptNS2
cd /$nom/ScriptNS2
fi
echo  "\e[1;32m\nTelechargement du script\e[1;30m"
sleep 1
###
wget https://welcome.gugus.ovh/dl/NS2.sh
###
wget 10.132.20.70/dl/NS2.sh
###
if [ /$nom/ScriptNS2/NS2.sh ]
then
echo  "\e[1;32m\nExecution du script\e[1;30m"
sleep 1
sh /$nom/ScriptNS2/NS2.sh
else
echo  "\e[1;31m\nErreur veuillez verifier que vous etes bien connecte sur internet !\e[1;30m"
exit
fi
;;

3)
if [ -d "/$nom/ScriptADDCP" ]
then
cd /$nom/ScriptADDCP
rm *
else
mkdir /$nom/ScriptADDCP
cd /$nom/ScriptADDCP
fi
echo  "\e[1;32m\nTelechargement du script\e[1;30m"
sleep 1
###
wget https://welcome.gugus.ovh/dl/ADDCP.sh
###
wget 10.132.20.70/dl/ADDCP.sh
###
if [ /$nom/ScriptADDCP/ADDCP.sh ]
then
echo  "\e[1;32m\nExecution du script\e[1;30m"
sleep 1
sh /$nom/ScriptADDCP/ADDCP.sh
else
echo  "\e[1;31m\nErreur veuillez verifier que vous etes bien connecte sur internet !\e[1;30m"
exit
fi
;;

4)
if [ -d "/$nom/ScriptADDCS" ]
then
cd /$nom/ScriptADDCS
rm *
else
mkdir /$nom/ScriptADDCS
cd /$nom/ScriptADDCS
fi
echo  "\e[1;32m\nTelechargement du script\e[1;30m"
sleep 1
###
wget https://welcome.gugus.ovh/dl/ADDCS.sh
###
wget 10.132.20.70/dl/ADDCS.sh
###
if [ /$nom/ScriptADDCS/ADDCS.sh ]
then
echo  "\e[1;32m\nExecution du script\e[1;30m"
sleep 1
sh /$nom/ScriptADDCS/ADDCS.sh
else
echo  "\e[1;31m\nErreur veuillez verifier que vous etes bien connecte sur internet !\e[1;30m"
exit
fi
;;

5)
if [ -d "/$nom/ScriptFICHIERS" ]
then
cd /$nom/ScriptFICHIERS
rm *
else
mkdir /$nom/ScriptFICHIERS
cd /$nom/ScriptFICHIERS
fi
echo  "\e[1;32m\nTelechargement du script\e[1;30m"
sleep 1
###
wget https://welcome.gugus.ovh/dl/FICHIERS.sh
###
wget 10.132.20.70/dl/FICHIERS.sh
###
if [ /$nom/ScriptFICHIERS/FICHIERS.sh ]
then
echo  "\e[1;32m\nExecution du script\e[1;30m"
sleep 1
sh /$nom/ScriptFICHIERS/FICHIERS.sh
else
echo  "\e[1;31m\nErreur veuillez verifier que vous etes bien connecte sur internet !\e[1;30m"
exit
fi
;;

6)
if [ -d "/$nom/ScriptUSER" ]
then
cd /$nom/ScriptUSER
rm *
else
mkdir /$nom/ScriptUSER
cd /$nom/ScriptUSER
fi
echo  "\e[1;32m\nTelechargement du script\e[1;30m"
sleep 1
###
wget https://welcome.gugus.ovh/dl/USER.sh
###
wget 10.132.20.70/dl/USER.sh
###
if [ /$nom/ScriptUSER/USER.sh ]
then
echo  "\e[1;32m\nExecution du script\e[1;30m"
sleep 1
sh /$nom/ScriptUSER/USER.sh
else
echo  "\e[1;31m\nErreur veuillez verifier que vous etes bien connecte sur internet !\e[1;30m"
exit
fi
;;

q)
exit 0
;;

*)
echo "\n\e[1;31mERREUR de saisie, veuillez relancer le script $0\n\e[30m"
exit 1
;;

esac
