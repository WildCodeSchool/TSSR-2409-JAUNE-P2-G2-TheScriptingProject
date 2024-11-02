#!/bin/bash
# Actions redondantes
# Fonction d'#authentification
#function #authentification {
#    read -p "Entrez l'identifiant de la machine cible : " identifiant
#    read -p "Entrez l'adresse IP de la machine :" IP
#    ssh $identifiant@$IP
#}

# Fonction de confirmation
function confirmation {
    read -p "Êtes-vous sûr de vouloir continuer ? (o/n) " confirmation
    if [ "$confirmation" != "o" ]; then
        echo "Action annulée."
        return 1
    fi
    return 0
}

# Fonction d'affichage de succès
function afficher_succes {
    echo "L'opération a réussie !"
}

# Fonction d'affichage d'erreur
function afficher_erreur {
    echo "L'opération a échouée !"
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

    case $cible in
    1) choix_utilisateur ;;
    2) choix_ordinateur ;;
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
    echo

    case $option in
    1) actions_utilisateur ;;
    2) informations_utilisateur ;;
    R) menu_principal ;;
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
    1) actions_ordinateur ;;
    2) informations_ordinateur ;;
    R) menu_principal ;;
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
        #authentification
        if confirmation; then
            read -p "Quel utilisateur voulez vous créer ?" useradd

            sudo useradd $useradd
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    2)
        #authentification
        if confirmation; then
            read -p "Pour quel utilisateur voulez vous changer le mot de passe ?" passwd
            sudo passwd $passwd
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    3)
        #authentification
        if confirmation; then
            read -p "Quel utilisateur voulez vous supprimer ?" userdel
            sudo userdel $userdel
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    4)
        #authentification
        if confirmation; then
            read -p "Quel utilisateur voulez vous désactiver ?" userdel
            sudo usermod -L $usermod
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    5)
        #authentification
        if confirmation; then
            read -p "Quel utilisateur voulez vous ajouter au groupe administrateur ?" userAdmin
            sudo usermod -aG sudo $userAdmin
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    6)
        #authentification
        if confirmation; then
            read -p "Quel utilisateur voulez vous ajouter au groupe local ?" username
            read -p "A quel groupe voulez vous ajouter l'utilisateur "$username" ?" usergroup
            sudo usermod -aG $usergroup $username
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    7)
        #authentification
        if confirmation; then
            read -p "Quel utilisateur voulez vous supprimer du groupe local ?" username
            read -p "De quel groupe voulez vous supprimer l'utilisateur "$username" ?" usergroup
            sudo deluser $username $usergroup
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    R) choix_utilisateur ;;
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
    A1)
        #authentification
        if confirmation; then
            shutdown now
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    A2)
        #authentification
        if confirmation; then
            reboot
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    A3)
        #authentification
        if confirmation; then
            logout
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    A4)
        #authentification
        if confirmation; then
            sudo apt update && sudo apt upgrade -y
            afficher_succes
        else
            afficher_erreur
        fi
        ;;
    A5)
        #authentification
        if confirmation; then
            read -p "Emplacement du nouveau dossier ?" path
            read -p "Quelle est le nom du dossier à créer ?" name
            mkdir -p $path/$name
        fi
        ;;
    A6)
        #authentification
        if confirmation; then
            read -p "Emplacement du dossier a supprimer :" path
            rm -r $path
        fi
        ;;
    A7)
        #authentification
        if confirmation; then
            echo #Prise de main à distance (GUI)
        fi
        ;;
    A8)
        #authentification
        if confirmation; then
            echo #Définition de règles de pare-feu
        fi
        ;;
    A9)
        #authentification
        if confirmation; then
            sudo ufw enable
        fi
        ;;
    A10)
        #authentification
        if confirmation; then
            sudo ufw disable
        fi
        ;;
    A11)
        #authentification
        if confirmation; then
            read -p "Quel logiciel voulez vous installer ?" soft
            sudo apt install $soft -y
        fi
        ;;
    A12)
        #authentification
        if confirmation; then
            read -p "Quel logiciel voulez vous désinstaller ?" soft
            sudo apt remove $soft -y
        fi
        ;;
    A13)
        #Exécution de script sur la machine distante
        if confirmation; then
            # authentification
            read -p "Quel est l'emplacement du script" path
            read -p "Quel est le nom du script ?" name
            cd $path && ./$name #eventuellement rajouter un chmod 755 $name
        fi
        ;;
    R) choix_ordinateur ;;
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
    1) last -F -w -R $user | grep 'seat0' | awk 'NR==1' ;;
    2) sudo chage -l $user | awk 'NR==1' ;;
    3) who -H -s ;;
    4) ls -ld $directory | awk '{print $1" "$3" "$4}' ;;
    5) ls -l $file | awk '{print $1" "$3" "$4}' ;;
    R) actions_utilisateur ;;
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
    1) cat /etc/os-release ;;
    2) nmcli device ;;
    3) ip -br -o addr ;;
    4) ip -br -o link ;;
    5) apt-mark showmanual ;;
    6) cat /etc/passwd ;;
    7) cat /proc/cpuinfo // lscpu ;;
    8) free -h # a revoir le formattage 
    ;;
    9) free -h // cat /proc/meminfo ;;
    10) df -h ;;
    11) mpstat ;;
    12) ss -tulpn | grep LISTEN # + formattage pour jsute le numéro ?
    ;;
    13)
        sudo iptables -L -n #A tester sur une linux
        ;;
    R) choix_ordinateur ;;
    Q) exit 0 ;;
    *) echo "Option invalide. Veuillez choisir 1-13, R ou Q"
        informations_ordinateur ;;
    esac
}

# Boucle principale
while true; do
    menu_principal
done
