#!/bin/bash
# Actions redondantes
#Fonction d'authentification
function authentification {
    read -p "Entrez l'identifiant de la machine cible : " identifiant
    read -p "Entrez l'adresse IP de la machine :" IP
    ssh $identifiant@$IP
}
log_file="/home/wilder/Desktop/loggo.log"

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
        echo echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'menu_pricipal'" >>$log_file
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
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'actions_ordinateurs'" >>$log_file
        ;;
    2)
        informations_ordinateur
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'informations_ordinateur'" >>$log_file
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
        if confirmation; then
            read -p "Quel utilisateur voulez vous créer ?" useradd
            sudo useradd $useradd
            echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Création de compte'" >>$log_file
            afficher_succes
        else
            echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Création de compte'" >>$log_file
            afficher_erreur
        fi
        ;;
    2)
        if confirmation; then
            read -p "Pour quel utilisateur voulez vous changer le mot de passe ?" passwd
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
            sudo usermod -aG $usergroup $username
            echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Ajout à un groupe local'" >>$log_file
            afficher_succes
        else
            echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Ajout à un groupe local'" >>$log_file
            afficher_erreur
        fi
        ;;
    7)
        if confirmation; then
            read -p "Quel utilisateur voulez vous supprimer du groupe local ?" username
            read -p "De quel groupe voulez vous supprimer l'utilisateur "$username" ?" usergroup
            sudo deluser $username $usergroup
            echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Sortie d’un groupe local'" >>$log_file
            afficher_succes
        else
            echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Sortie d’un groupe local'" >>$log_file
            afficher_erreur
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
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Création de répertoire'" >>$log_file
        read -p "Emplacement du nouveau dossier ?" path
        read -p "Quelle est le nom du dossier à créer ?" name
        mkdir -p $path/$name
    fi ;;
    6) if confirmation; then
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Suppression de répertoire'" >>$log_file
        read -p "Emplacement du dossier a supprimer :" path
        rm -r $path
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
    11) if confirmation; then
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Installation de logiciel'" >>$log_file
        read -p "Quel logiciel voulez vous installer ?" soft
        sudo apt update && sudo apt install $soft -y
    fi ;;
    12) if confirmation; then
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Désinstallation de logiciel'" >>$log_file
        read -p "Quel logiciel voulez vous désinstaller ?" soft
        sudo apt remove $soft -y
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
    read -p "Choisissez une option : (1-5, R ou Q) : " option

    case $option in
    1) if confirmation; then
        last -F -w -R $user | grep 'seat0' | awk 'NR==1'
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Date de dernière connexion d’un utilisateur'" >>$log_file
        ;;
    2) if confirmation; then
        sudo chage -l $user | awk 'NR==1'
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Date de dernière modification du mot de passe'" >>$log_file
        ;;
    3) if confirmation; then
        who -H -s
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Liste des sessions ouvertes par l'utilisateur'" >>$log_file
        ;;
    4) if confirmation; then
        ls -ld $directory | awk '{print $1" "$3" "$4}'
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Droits/permissions de l’utilisateur sur un dossier'" >>$log_file
        ;;
    5) if confirmation; then
        ls -l $file | awk '{print $1" "$3" "$4}'
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Droits/permissions de l’utilisateur sur un fichier'" >>$log_file
        ;;
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
    read -p "Choisissez une option : (1-13, R ou Q) : " option

    case $option in # checker les formattages
    1) if confirmation; then
        cat /etc/os-release
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Version de l'OS'" >>$log_file
        ;;
    2) if confirmation; then
        nmcli device
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Nombre d'interface'" >>$log_file
        ;;
    3) if confirmation; then
        ip -br -o addr
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Adresse IP de chaque interface'" >>$log_file
        ;;
    4) if confirmation; then
        ip -br -o link
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Adresse MAC'" >>$log_file
        ;;
    5) if confirmation; then
        apt-mark showmanual
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Liste des applications/paquets installés'" >>$log_file
        ;;
    6) if confirmation; then
        _l="/etc/login.defs"; _p="/etc/passwd"; l=$(grep "^UID_MIN" $_l); l1=$(grep "^UID_MAX" $_l); echo "----------[ Normal User Accounts ]---------------"; awk -F':' -v "min=${l##UID_MIN}" -v "max=${l1##UID_MAX}" '{ if ( $3 >= min && $3 <= max && $7 != "/sbin/nologin" ) print $0 }' "$_p"
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Liste des utilisateurs locaux'" >>$log_file
        ;;
    7) if confirmation; then
        lscpu | sed -n '1p;5p;8p;20,22p'
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Type de CPU, nombre de cœurs, etc.'" >>$log_file
        ;;
    8) if confirmation; then
        free -h # a revoir le formattage
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Mémoire RAM totale'" >>$log_file
        ;;
    9) if confirmation; then
        cat /proc/meminfo | awk 'NR==1' | sed 's/MemTotal:/Mémoire_RAM_Totale:/'
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Utilisation de la RAM'" >>$log_file
        ;;
    10) if confirmation; then
        df -h
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Utilisation du disque'" >>$log_file
        ;;
    11) if confirmation; then
        mpstat | awk 'NR!=1'
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Utilisation du processeur'" >>$log_file
        ;;
    12) if confirmation; then
        ss -tulpn | grep LISTEN # + formattage pour jsute le numéro ?
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Liste des ports ouverts'" >>$log_file
        ;;
    13) if confirmation; then
        sudo ufw status
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'action 'Statut du pare-feu'" >>$log_file
        ;;
    R)
        choix_ordinateur
        echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi le menu 'choix_ordinateur'" >>$log_file
        ;;
    Q) exit 0 ;;
    *)
        echo "Option invalide. Veuillez choisir 1-13, R ou Q"
        informations_ordinateur
        ;;
    esac
}

function start_log {
    echo -e "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-********StartScript********" >/home/wilder/Desktop/loggo.log
}

trap 'echo -n "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-********EndScript********" >> /home/wilder/Desktop/loggo.log' EXIT
trap 'echo -e "\e[32mATTENTION:\e[0m une erreur sest produite. Vérifiez dans le fichier $log_file"; echo -n "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-********EndScript********" >> /home/wilder/Desktop/loggo.log' SIGINT SIGKILL

start_log

# Boucle principale
while true; do
    menu_principal
done
