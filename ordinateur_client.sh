#!/bin/bash
# Actions redondantes
#Fonction d'authentification
function authentification {
    read -p "Entrez l'identifiant de la machine cible : " identifiant
    read -p "Entrez l'adresse IP de la machine :" IP
    ssh $identifiant@$IP
}
#sudo touch 
sudo touch /var/log/log_evt.log
log_file="/var/log/log_evt.log"
sudo chmod 777 /var/log/log_evt.log
# Fonction de confirmation
function confirmation {
    read -p "Êtes-vous sûr de vouloir continuer ? (o/n) " confirmation
    if [ "$confirmation" != "o" ]; then
        echo "Action annulée."
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER- Action annulée" >>$log_file
        return 1
    fi
    return 0
}

# Fonction d'affichage de succès
function afficher_succes {
    echo "L'opération a réussie !"
     echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-L'opération à réussie !" >>$log_file
}

# Fonction d'affichage d'erreur
function afficher_erreur {
    echo "L'opération a échouée !"
     echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-L'opération a échouée !" >>$log_file
}
# Menu principal
function menu_principal {
    echo
    echo
    echo "              === Choisir une Cible ==="
    echo "1. Utilisateur"
    echo "2. Ordinateur"
    echo "Q. Quitter"
    read -p "Choisissez une cible : (1, 2 ou Q) : " cible
    echo "Choix de la cible $cible"
     echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi la cible $cible" >>$log_file

    case $cible in
    1)
        choix_utilisateur
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'choix_utilisateur'" >>$log_file
        ;;
    2)
        choix_ordinateur
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'choix_ordinateur'" >>$log_file
        ;;
    Q) exit 0 ;;
    *)
        echo "Option invalide. Veuillez choisir 1, 2 ou Q."
        menu_principal
        ;;
    esac
}

# Actions ou informations sur les utilisateurs
function choix_utilisateur {
    echo
    echo
    echo "              === Actions ou Informations sur Utilisateur ==="
    echo "1. Actions"
    echo "2. Informations"
    echo "R. Retour au menu principal"
    echo "Q. Quitter le script"
    read -p "Choisissez une option : (1-2, R ou Q) : " option

    case $option in
    1)
        actions_utilisateur
        echo "Vous avez choisi le menu 'actions_utlisateurs'" >>$log_file
        ;;
    2)
        informations_utilisateur
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'informations_utlisateurs'" >>$log_file
        ;;
    R)
        menu_principal
        echo  echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'menu_pricipal'" >>$log_file
        ;;
    Q) exit 0 ;;
    *)
        echo "Option invalide. Veuillez choisir 1, 2, R ou Q"
        choix_utilisateur
        ;;
    esac
}

# Actions ou informations sur les ordinateurs
function choix_ordinateur {
    echo
    echo
    echo "              === Actions ou Informations sur Ordinateur ==="
    echo "1. Actions"
    echo "2. Informations"
    echo "R. Retour au menu principal"
    echo "Q. Quitter le script"
    read -p "Choisissez une option : (1-2, R ou Q) : " option

    case $option in
    1)
        actions_ordinateur
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'actions_ordinateurs'" >> $log_file
        ;;
    2)
        informations_ordinateur
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'informations_ordinateur'" >> $log_file
        ;;
    R)
        menu_principal
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'menu_pricipal'" >>$log_file
        ;;
    Q) exit 0 ;;
    *)
        echo "Option invalide. Veuillez choisir 1, 2, R ou Q"
        choix_ordinateur
        ;;
    esac
}

# Actions sur les utilisateurs
function actions_utilisateur {
    echo
    echo
    echo "              === Actions sur Utilisateur ==="
    echo "1. Création de compte"
    echo "2. Changement de mot de passe"
    echo "3. Suppression de compte"
    echo "4. Désactivation de compte"
    echo "5. Ajout à un groupe d'administration"
    echo "6. Ajout à un groupe local"
    echo "7. Sortie d’un groupe local"
    echo "R. Retour"
    echo "Q. Quitter le script"
    read -p "Choisissez une action : (1-7, R ou Q) : " action

    case $action in
    1)
        if confirmation 
        then
            read -p "Quel utilisateur voulez vous créer ?" useradd
                if cat /etc/passwd | grep $useradd >/dev/null 
                then
                     echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Création de compte'" >>$log_file
                    afficher_erreur
                else
                    sudo useradd $useradd 
                     echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Création de compte'" >>$log_file
                    afficher_succes
                fi
        fi
        ;;
    2)
        if confirmation; then
            read -p "Pour quel utilisateur voulez vous changer le mot de passe ?" passwd
        fi    
        if cat /etc/passwd && grep $passwd >/dev/null ;then
            sudo passwd $passwd
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Changement de mot de passe'" >>$log_file
            afficher_succes
        else
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Changement de mot de passe'" >>$log_file
            afficher_erreur
        fi
        ;;
    3)
        if confirmation; then
            read -p "Quel utilisateur voulez vous supprimer ?" userdel
        fi
        if cat /etc/passwd && grep $userdel > /dev/null
        then
            sudo userdel $userdel
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Suppression de compte'" >>$log_file
            afficher_succes
        else
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Suppression de compte'" >>$log_file
            afficher_erreur
        fi
        ;;
    4)
        if confirmation; then
            read -p "Quel utilisateur voulez vous désactiver ?" userdel
        fi
        if cat /etc/passwd && grep $userdel > /dev/null ;
        then   
            sudo usermod -L $usermod
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Désactivation de compte'" >>$log_file
            afficher_succes
        else
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action '8Désactivation de compte'" >>$log_file
            afficher_erreur
        fi
        ;;
    5)
        if confirmation; then
            read -p "Quel utilisateur voulez vous ajouter au groupe administrateur ?" userAdmin
        fi
        if cat /etc/passwd && grep $userAdmin > /dev/null
        then
            sudo usermod -aG sudo $userAdmin
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Ajout à un groupe d'administration'" >>$log_file
            afficher_succes
        else
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Ajout à un groupe d'administration'" >>$log_file
            afficher_erreur
        fi
        ;;
    6)
        if confirmation; then
            read -p "Quel utilisateur voulez vous ajouter au groupe local ?" username
            read -p "A quel groupe voulez vous ajouter l'utilisateur "$username" ?" usergroup
        fi 
        if cat /etc/group | grep $usergroup >/dev/null
        then 
            cat /etc/passwd | grep $username >/dev/null
            if cat /etc/passwd | grep $username >/dev/null
            then
                sudo usermod -aG $usergroup $username
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Ajout à un groupe local'" >>$log_file
                afficher_succes
            else
                echo "L'utilisateur n'existe pas"
                afficher_erreur
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Ajout à un groupe local'" >>$log_file
            fi
        else
            echo "Le groupe n'existe pas"
            afficher_erreur
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Ajout à un groupe local'" >>$log_file
        fi
        ;;
    7)
        if confirmation; then
            read -p "Quel utilisateur voulez vous supprimer du groupe local ?" username
            read -p "De quel groupe voulez vous supprimer l'utilisateur "$username" ?" usergroup
        fi
        if cat /etc/group | grep $usergroup >/dev/null
        then 
            cat /etc/passwd | grep $username >/dev/null
            if cat /etc/passwd | grep $username >/dev/null
            then
                sudo deluser $username $usergroup
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Sortie d’un groupe local'" >>$log_file
                afficher_succes
            else
                echo "L'utilisateur n'existe pas"
                afficher_erreur
            fi
        else
            echo "Le groupe n'existe pas"
            afficher_erreur
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Sortie d’un groupe local'" >>$log_file
            
        fi
        ;;
    R)
        choix_utilisateur
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi 'Retour au menu choix_utilisateur'" >>$log_file
        ;;
    Q) exit 0 ;;
    *)
        echo "Option invalide ! Veuillez choisir 1-7, R ou Q"
        actions_utilisateur
        ;;
    esac
}

# Actions sur les ordinateurs
function actions_ordinateur {
    echo
    echo
    echo "              === Actions sur Ordinateur ==="
    echo "1. Arrêt"
    echo "2. Redémarrage"
    echo "3. Verrouillage"
    echo "4. Mise à jour du système"
    echo "5. Création de répertoire"
    echo "6. Suppression de répertoire"
    echo "7. Prise de main à distance (GUI)"
    echo "8. Définition de règles de pare-feu"
    echo "9. Activation du pare-feu"
    echo "10. Désactivation du pare-feu"
    echo "11. Installation de logiciel"
    echo "12. Désinstallation de logiciel"
    echo "13. Exécution de script sur la machine distante"
    echo "R. Retour"
    echo "Q. Quitter le script"
    read -p "Choisissez une action : (1-13, R ou Q) : " action

    case $action in
    1) if confirmation; then
        shutdown now
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Arrêt'" >>$log_file
        afficher_succes
    else
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Arrêt'" >>$log_file
        afficher_erreur
    fi ;;
    2) if confirmation; then
        reboot
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Redémarrage'" >>$log_file
        afficher_succes
    else
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Redémarrage'" >>$log_file
        afficher_erreur
    fi ;;
    3) if confirmation; then
        logout
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Verrouillage'" >>$log_file
        afficher_succes
    else
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Verrouillage'" >>$log_file
        afficher_erreur
    fi ;;
    4) if confirmation; then
        sudo apt update && sudo apt upgrade -y
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Mise à jour du système'" >>$log_file
        afficher_succes
    else
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Mise à jour du système'" >>$log_file
        afficher_erreur
    fi ;;
    5) if confirmation; then
        read -p "Emplacement du nouveau dossier ?" path
       fi
       if [ -e $path ]
       then
            read -p "Quelle est le nom du dossier à créer ?" name
            mkdir -p $path/$name
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Création de répertoire'" >>$log_file
            afficher_succes
        else
        echo "Le chemin est incorrect"
        afficher_erreur
        fi ;;
    6) if confirmation; then
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Suppression de répertoire'" >>$log_file
        read -p "Emplacement du dossier a supprimer :" path
       fi 
       if [ -e $path ]
        then 
            rm -r $path
            afficher_succes
        else
            echo "Le chemin vers le dossier est incorrect"
            afficher_erreur
        fi ;;
    7) if confirmation; then
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Prise de main à distance (GUI)'" >>$log_file
        echo #Prise de main à distance (GUI)
    fi ;;
    8) if confirmation; then
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Définition de règles de pare-feu'" >>$log_file
        echo #Définition de règles de pare-feu
    fi ;;
    9) if confirmation; then
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Activation du pare-feu'" >>$log_file
        sudo ufw enable
    fi ;;
    10) if confirmation; then
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Désactivation du pare-feu'" >>$log_file
        sudo ufw disable
    fi ;;
    11) if confirmation; 
        then
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Installation de logiciel'" >>$log_file
            read -p "Quel logiciel voulez vous installer ?" soft
        fi
        if  dpkg -l | grep $soft  >/dev/null
        then
            echo "$soft est déjà installé sur la machine"
            afficher_erreur 
        else
            sudo apt update && sudo apt install $soft -y
            afficher_succes
        fi ;;
    12) if confirmation; 
        then
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Désinstallation de logiciel'" >>$log_file
        read -p "Quel logiciel voulez vous désinstaller ?" soft
        fi
        if dpkg -l | grep $soft  >/dev/null
        then 
            sudo apt remove $soft -y
                if dpkg -l | grep $soft  >/dev/null
                then
                    echo "$soft n'a pas pu être désinstallé"
                    afficher_erreur
                else
                    afficher_succes
                fi        
        else 
            echo "$soft n'est pas installé sur la machine"
            afficher_erreur
        fi ;;
    13) if confirmation; then
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Exécution de script sur la machine distante'" >>$log_file
        read -p "Quel est l'emplacement du script" path
        read -p "Quel est le nom du script ?" name
        cd $path && ./$name #eventuellement rajouter un chmod 755 $name
    fi ;;
    R)
        choix_ordinateur
         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi 'Retour au menu choix_utilisateur'" >>$log_file
        ;;
    Q) exit 0 ;;
    *)
        echo "Option invalide. Veuillez choisir 1-13, R ou Q"
        actions_ordinateur
        ;;
    esac
}

# Informations sur les utilisateurs
function informations_utilisateur {
    echo
    echo
    echo "              === Informations sur Utilisateur ==="
    echo "1. Date de dernière connexion d’un utilisateur"
    echo "2. Date de dernière modification du mot de passe"
    echo "3. Liste des sessions ouvertes par l'utilisateur"
    echo "4. Droits/permissions de l’utilisateur sur un dossier"
    echo "5. Droits/permissions de l’utilisateur sur un fichier"
    echo "R. Retour"
    echo "Q. Quitter le script"
    read -p "Choisissez une ou plusieurs option(s) : (1-5, R ou Q) : " option_info_u
    nbr_info=$(echo $option_info_u | wc -w )

    if [ $nbr_info -le 1 ]
    then
        case $option in
        1)  if confirmation; 
            then
            read -p "Veuillez entrer le nom de l'utilisateur pour connaître la date de sa dernière connexion" userco
            fi 
            if cat /etc/passwd | grep $userco >/dev/null
            then
                last -F -w -R $userco | grep 'seat0' | awk 'NR==1'
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Date de dernière connexion d’un utilisateur'" >>$log_file
            else 
                echo "L'utilisateur n'existe pas" 
                afficher_erreur
            fi ;;
        2) if confirmation; 
            then
            read -p "Veuillez entrer le nom de l'utilisateur pour connaître la date de son dernier changement de mot de passe" userage
            fi
                if cat /etc/passwd | grep $userage >/dev/null
                then
                sudo chage -l $userage | awk 'NR==1'
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Date de dernière modification du mot de passe'" >>$log_file
                else
                echo "L'utilisateur n'existe pas"
                afficher_erreur
                fi ;;
        3) if confirmation; 
            then
            who -H -s
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Liste des sessions ouvertes par l'utilisateur'" >>$log_file
            fi ;;
        4) if confirmation; 
            then
                read -p "Merci d'indiquer le dossier dont vous souhaitez consulter les permissions " directory
            fi
            if [ -d $directory ]
                then 
                ls -ld $directory | awk '{print $1" "$3" "$4}'
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Droits/permissions de l’utilisateur sur un dossier'" >>$log_file
                else
                echo "Le dossier $directory n'existe pas"
                afficher_erreur
            fi ;;
        5)  if confirmation; 
            then
                read -p "Merci d'indiquer le fichier dont vous souhaitez consulter les permissions " $file
            fi
            if [ -f $file ]
            then
                ls -l $file | awk '{print $1" "$3" "$4}'
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Droits/permissions de l’utilisateur sur un fichier'" >>$log_file
                afficher_succes
            else
                echo "Le fichier $file n'existe pas"
                afficher_erreur       
            fi ;;
        R)
            actions_utilisateur
             echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi 'Retour au menu actions_utilisateur'" >>$log_file
            ;;
        Q) exit 0 ;;
        *)
            echo "Option invalide. Veuillez choisir 1-5, R ou Q"
            informations_utilisateur
            ;;
        esac
    else
        date=$(date +%Y%m%d)
            if [ ! -f /home/$USER/Documents/info_utilisateur_$date.txt ]
            then
            touch /home/$USER/Documents/info_utilisateur_$date.txt
            info_log=/home/$USER/Documents/info_utilisateur_$date.txt
            fi
        for arg in $option_info_u;do
            case $arg in
            1)  if confirmation; 
                then
                read -p "Veuillez entrer le nom de l'utilisateur pour connaître la date de sa dernière connexion" userco
                fi 
                if cat /etc/passwd | grep $userco >/dev/null
                then
                    echo "$(last -F -w -R $userco | grep 'seat0' | awk 'NR==1')" >> $info_log
                    separation
                    echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Date de dernière connexion d’un utilisateur'" >>$log_file
                else 
                    echo "L'utilisateur n'existe pas" 
                    afficher_erreur
                fi ;;
            2) if confirmation; 
                then
                read -p "Veuillez entrer le nom de l'utilisateur pour connaître la date de son dernier changement de mot de passe" userage
                fi
                    if cat /etc/passwd | grep $userage >/dev/null
                    then
                        echo "$(sudo chage -l $userage | awk 'NR==1' )" >> $info_log
                        separation
                         echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Date de dernière modification du mot de passe'" >>$log_file
                    else
                        echo "L'utilisateur n'existe pas"
                        afficher_erreur
                    fi ;;
            3) if confirmation; 
                then
                echo "$(who -H -s)">> $info_log
                separation
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Liste des sessions ouvertes par l'utilisateur'" >>$log_file
                fi ;;
            4) if confirmation; 
                then
                    read -p "Merci d'indiquer le dossier dont vous souhaitez consulter les permissions " directory
                fi
                if [ -d $directory ]
                    then 
                    echo "$(ls -ld $directory | awk '{print $1" "$3" "$4}')" >>$info_log
                    separation
                     echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Droits/permissions de l’utilisateur sur un dossier'" >>$log_file
                    else
                    echo "Le dossier $directory n'existe pas"
                    afficher_erreur
                fi ;;
            5)  if confirmation; 
                then
                    read -p "Merci d'indiquer le fichier dont vous souhaitez consulter les permissions " file
                fi
                if [ -f $file ]
                then
                    echo "$(ls -l $file | awk '{print $1" "$3" "$4}' )">> $info_log
                     echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Droits/permissions de l’utilisateur sur un fichier'" >>$log_file
                    afficher_succes
                else
                    echo "Le fichier $file n'existe pas"
                    afficher_erreur       
                fi ;;
            R)
                actions_utilisateur
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi 'Retour au menu actions_utilisateur'" >>$log_file
                ;;
            Q) exit 0 ;;
            *)
                echo "Option invalide. Veuillez choisir 1-5, R ou Q"
                informations_utilisateur
                ;;
            esac
        done
    fi
}

# Fonction pour les informations sur les ordinateurs
function informations_ordinateur {
    echo
    echo
    echo "              === Informations sur Ordinateur ==="
    echo "1. Version de l'OS"
    echo "2. Nombre d'interface"
    echo "3. Adresse IP de chaque interface"
    echo "4. Adresse MAC"
    echo "5. Liste des applications/paquets installés"
    echo "6. Liste des utilisateurs locaux"
    echo "7. Type de CPU, nombre de cœurs, etc."
    echo "8. Mémoire RAM totale"
    echo "9. Utilisation de la RAM"
    echo "10. Utilisation du disque"
    echo "11. Utilisation du processeur"
    echo "12. Liste des ports ouverts"
    echo "13. Statut du pare-feu"
    echo "R. Retour"
    echo "Q. Quitter le script"
    read -p "Choisissez une ou plusieurs option(s) : (1-13, R ou Q) : " option_i_o
    nbr_info_o=$(echo $option_i_o | wc -w )

    if [ $nbr_info_o -le 1 ]
    then
            case $option_i_o in # checker les formattages
            1) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Version de l'OS'" >>$log_file
                cat /etc/os-release | awk 'NR==1' | sed 's/PRETTY_NAME=/Version_OS:/' 
               fi ;;
            2) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Nombre d'interface'" >>$log_file
                nmcli device | awk 'END {print NR - 1}'
               fi ;;
            3) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Adresse IP de chaque interface'" >>$log_file
                ip -br -o addr | awk '{print "interface : " $1"\n"," adresse IPv4 : "$3"\n "}'
               fi ;;
            4) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Adresse MAC'" >>$log_file
                ip -br -o link | awk '{print "interface : " $1"\n"," adresse MAC : "$3"\n"}'
               fi ;;
            5) if confirmation; then
                apt-mark showmanual
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Liste des applications/paquets installés'" >>$log_file
            fi ;;
            6) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Liste des utilisateurs locaux'" >>$log_file
                _l="/etc/login.defs"; _p="/etc/passwd"; l=$(grep "^UID_MIN" $_l); l1=$(grep "^UID_MAX" $_l); echo "----------[ Normal User Accounts ]---------------"; awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max && $7 != "/sbin/nologin" ) print $0 }' "$_p"
               fi ;;
            7) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Type de CPU, nombre de cœurs, etc.'" >>$log_file
                lscpu | sed -n '1p;5p;8p;20,22p'
               fi ;;
            8) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Mémoire RAM totale'" >>$log_file
                free -h # a revoir le formattage
               fi ;;
            9) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Utilisation de la RAM'" >>$log_file
                cat /proc/meminfo | awk 'NR==1' | sed 's/MemTotal:/Mémoire_RAM_Totale:/'
                fi ;;
            10) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Utilisation du disque'" >>$log_file
                df -h
                fi ;;
            11) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Utilisation du processeur'" >>$log_file
                mpstat | awk 'NR!=1'
                fi ;;
            12) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Liste des ports ouverts'" >>$log_file
                ss -tulpn | grep LISTEN # + formattage pour jsute le numéro ?
                fi ;;
            13) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Statut du pare-feu'" >>$log_file
                sudo ufw status
                fi ;;
            R)
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'choix_ordinateur'" >>$log_file
                choix_ordinateur
                ;;
            Q) exit 0 ;;
            *)
                echo "Option invalide. Veuillez choisir 1-13, R ou Q"
                informations_ordinateur
                ;;
            esac
    else
        date=$(date +%Y%m%d)
            if [ ! -f /home/$USER/Documents/info_utilisateur_$date.txt ]
            then
            touch /home/$USER/Documents/info_utilisateur_$date.txt
            #info_log=/home/$USER/Documents/info_utilisateur_$date.txt
            fi
        for arg in $option_info_u;do
            case $arg in
            1) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Version de l'OS'" >>$log_file
                echo "$(cat /etc/os-release | awk 'NR==1' | sed 's/PRETTY_NAME=/Version_OS:/')" >> $info_log
                separation
               fi ;;
            2) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Nombre d'interface'" >>$log_file
                echo "$(nmcli device | awk 'END {print NR - 1}')">> $info_log
                separation
               fi ;;
            3) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Adresse IP de chaque interface'" >>$log_file
                 echo "$( ip -br -o addr | awk '{print "interface : " $1"\n"," adresse IPv4 : "$3"\n "}')">> $info_log
                separation
               fi ;;
            4) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Adresse MAC'" >>$log_file
                 echo "$(ip -br -o link | awk '{print "interface : " $1"\n"," adresse MAC : "$3"\n"}')">> $info_log
                separation
               fi ;;
            5) if confirmation; then
                echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Liste des applications/paquets installés'" >>$log_file
                | echo "$(apt-mark showmanual)">> $info_log
               separation
               fi ;;
            6) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Liste des utilisateurs locaux'" >>$log_file
                 echo "$(_l="/etc/login.defs"; _p="/etc/passwd"; l=$(grep "^UID_MIN" $_l); l1=$(grep "^UID_MAX" $_l); echo "----------[ Normal User Accounts ]---------------"; awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max && $7 != "/sbin/nologin" ) print $0 }' "$_p")" >> $info_log
               separation
               fi ;;
            7) if confirmation; then
                echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Type de CPU, nombre de cœurs, etc.'" >>$log_file
                echo "$(lscpu | sed -n '1p;5p;8p;20,22p')" >>$info_log
                separation
               fi ;;
            8) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Mémoire RAM totale'" >>$log_file
                 echo "$(free -h)" >> $info_log
                separation
               fi ;;
            9) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Utilisation de la RAM'" >>$log_file
                 echo "$(cat /proc/meminfo | awk 'NR==1' | sed 's/MemTotal:/Mémoire_RAM_Totale:/')" >> $info_log
                separation
                fi ;;
            10) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Utilisation du disque'" >>$log_file
                echo "$( df -h )" >>  $info_log
                separation
                fi ;;
            11) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Utilisation du processeur'" >>$log_file
                echo "$(mpstat | awk 'NR!=1')" >> $info_log
                separation
                fi ;;
            12) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Liste des ports ouverts'" >>$log_file
                 echo "$(ss -tulpn | grep LISTEN )" >> $info_log
                separation
                fi ;;
            13) if confirmation; then
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Statut du pare-feu'" >>$log_file
                 echo "$(sudo ufw status )" >> $info_log
                fi ;;
            R)
                 echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'choix_ordinateur'" >>$log_file
                 choix_ordinateur
                ;;
            Q) exit 0 ;;
            *)
                echo "Option invalide. Veuillez choisir 1-13, R ou Q"
                informations_ordinateur
                ;;
            esac
        done
    fi
}

function start_log {
    echo -e "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-********StartScript********" >/home/wilder/Desktop/loggo.log
}
function separation {
    echo -e "--------------------------------------------------------------------------------------------\n" >> /home/$USER/Documents/info_utilisateur_$date.txt

}
trap 'echo -n "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-********EndScript********" >> /home/wilder/Desktop/loggo.log' EXIT
trap 'echo -e "\e[32mATTENTION:\e[0m une erreur sest produite. Vérifiez dans le fichier $log_file"; echo -n "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-********EndScript********" >> /home/wilder/Desktop/loggo.log' SIGINT SIGKILL

start_log

# Boucle principale
while true; do
    menu_principal
done
