#menu d'options 1 
    # Action
        # Sur cet ordi
        # Remote
    # Information 
        #Sur cet ordi
        # Remote

# Menu 2 Action
    #A1 : Création de compte utilisateur local A VERIF
        # !/bin/bash

        # demander le nom du compte à créer dans la variable
        read -p "Quel est le nom d'utilisateur ?" nom

        # test si le compte demandé existe
        if cat /etc/passwd | grep $nom >/dev/null; then # SI existe

            # => affiche "le user existe déjà"
            echo "$nom exist"
            exit 1

        # si existe pas

        else
            #        => demande de la creation du compte (confirmation) [O/N]
            read -p "Confirmation de la création du Compte [o/n]" validation
            if [ $validation="o" ]; then
                #création user
                sudo useradd $nom
                if cat /etc/passwd | grep $nom >/dev/null; then
                    echo "compte $nom bien crée => OK"
                else
                    echo "compte $nom NON crée => NOK"
                    exit 1
                fi
            else
                # si NON => sortie du script
                echo "Création de compte annulée"
                exit 1
            fi
        fi

    #A2 : changement de mdp
    #Vérfie l'utilisateur existe (si vide alors on passe l'étape)
    #Mettre l'ancien mdp 
    #Mettre nouveau mdp
    #Confirmation nouveau mdp
        #Message erreur / changement réussi


    #A3 suppression de compte utilsiateur local 
    ##!/bin/bash

    choice=1
    while [ $choice = "1" ]
    do
        echo "Menu:"
        echo "1 - Supprimer un utilisateur"
        echo "2 - Ajouter un utilisateur"
        echo "3 - Quitter"
        read -p "Choisissez une option: " choice

        case $choice in




        1)
            # CHOIX 1 SUPPRESSION

            read -p "Quel utilisateur doit être supprimé ?" user_name
            #Tester si l'utilisateur à supprimer existe
            if cat /etc/passwd | grep $user_name #> /dev/null
            then
                #cat /etc/passwd | grep $user_name    
                read -p "Confirmation de la suppression de l'utilisateur $user_name [o/n/e]" validation
                case $validation in
                o)
                    # suppression de l'utilisisateur user_name
                    #sudo userdel $user_name && echo "VALIDATION de la suppression de $user_name"
                    sudo userdel $user_name
                    if cat /etc/passwd | grep -wq "$user_name" #> /dev/null
                    then
                        echo "ECHEC suppression de $user_name"
                    else
                        echo "VALIDATION de la suppression de $user_name"
                    fi
                    ;;
                n)
                    # pas de suppression
                    echo "Pas de suppression du compte $user_name => Sortie du script"
                    # sorti du script
                    #exit 1
                    ;;
                *)
                    echo "Erreur de saisie"
                    #exit 1
                    ;;
                esac
            else
                echo "Utilisateur $user_name inconnu"
                #exit 1
            fi
            ;;

    #A4 Désactivation compte utilisateur local
    #Verif utilisateur existe
        #SI non -> erreur
        #SI oui ->Confirmation 
            #commande désac
        #SI non -> erreur

    #A5 ajout à un grp d'adminsitration 
    #Verif utilisateur existe
    #Demande quel grp d'admin ?
        #Verif grp existe
            #Confirmation 
        #SI non -> erreur

    #A6 ajout à un grp local
    #Verif utilisateur existe
        #SI non -> erreur
    #Demande quel grp local ?
        #Verif grp existe
            #Confirmation 
        #SI non -> erreur

    #A7  sortie d'un groupe local
    #Verif utilisateur existe
        #SI non -> erreur
    #Demande quel grp local ?
        #Verif grp existe
            #Confirmation 
        #SI non -> erreur
    # Commande sortie de grp 
        #Confirmation
            #Msg validation
        #Msg erreur








#Menu 2 Info
    #I1 Date dernière connexion user
        #Recup l'info 
        # L'afficher
        # erreur ? 
    #I2 Date dernière modif mdp
        # Si user existe -> confirmation    Si non msg erreur
        # passwd -S $user
        # Afficher en timestamp 
    #I3 Liste des sessions ouvertes par l'user
        # Quel user ? 
        #Si user existe -> confirmation    Si non msg erreur
    #I4 Droits et perms de l'user sur un dossier 
        #Quel user ?
        #Si user existe -> confirmation    Si non msg erreur
        #Quel Dossier (forunir un chemin absolu) ? 
        #Si dossier existe (utiliser le chemin) -> confirmation    Si non msg erreur
    #I5 Droits et perms de l'user sur un fichier
        #Quel user ?
        #Si user existe -> confirmation    Si non msg erreur
        #Quel fichier (forunir un chemin absolu) ? 
        #Si fichier existe (utiliser le chemin) -> confirmation    Si non msg erreur





