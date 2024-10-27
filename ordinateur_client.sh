#!/bin/bash

# Fonction pour afficher le menu principal
function menu_principal {
    echo "=== Choisir une Cible ==="
    echo "1. Utilisateur"
    echo "2. Ordinateur"
    echo "3. Quitter"
    read -p "Choisissez une cible : (1 ou 2) " cible

    case $cible in
    1) choix_utilisateur ;;
    2) choix_ordinateur ;;
    3) exit 0 ;;
    *)
        echo "Option invalide. Veuillez choisir 1, 2 ou 3."
        menu_principal
        ;;
    esac
}

# Fonction pour choisir les actions ou informations sur les utilisateurs
function choix_utilisateur {
    echo "=== Actions ou Informations sur Utilisateur ==="
    echo "1. Actions"
    echo "2. Informations"
    echo "3. Retour"
    read -p "Choisissez une option : (1, 2 ou 3) " option

    case $option in
    1) actions_utilisateur ;;
    2) informations_utilisateur ;;
    3) menu_principal ;;
    *)
        echo "Option invalide. Veuillez choisir 1, 2 ou 3."
        choix_utilisateur
        ;;
    esac
}

# Fonction pour choisir les actions ou informations sur les ordinateurs
function choix_ordinateur {
    echo "=== Actions ou Informations sur Ordinateur ==="
    echo "1. Actions"
    echo "2. Informations"
    echo "3. Retour"
    read -p "Choisissez une option : (1, 2 ou 3) " option

    case $option in
    1) actions_ordinateur ;;
    2) informations_ordinateur ;;
    3) menu_principal ;;
    *)
        echo "Option invalide. Veuillez choisir 1, 2 ou 3."
        choix_ordinateur
        ;;
    esac
}

# Fonction pour les actions sur les utilisateurs
function actions_utilisateur {
    echo "=== Actions sur Utilisateur ==="
    echo "A1. Création de compte"
    echo "A2. Changement de mot de passe"
    echo "A3. Suppression de compte"
    echo "A4. Désactivation de compte"
    echo "A5. Ajout à un groupe d'administration"
    echo "A6. Ajout à un groupe local"
    echo "A7. Sortie d’un groupe local"
    echo "B. Retour"
    read -p "Choisissez une action : (A1, A2, A3 etc.) " action

    case $action in
    A1) action_creation_compte ;;
    A2) action_changement_mdp ;;
    A3) action_suppression_compte ;;
    A4) action_desactivation_compte ;;
    A5) action_ajout_groupe_admin ;;
    A6) action_ajout_groupe_local ;;
    A7) action_sortie_groupe_local ;;
    B) choix_utilisateur ;;
    *)
        echo "Option invalide. Veuillez choisir A1, A2, A3, etc."
        actions_utilisateur
        ;;
    esac
}

# Fonction pour les actions sur les ordinateurs
function actions_ordinateur {
    echo "=== Actions sur Ordinateur ==="
    echo "A1. Arrêt"
    echo "A2. Redémarrage"
    echo "A3. Verrouillage"
    echo "A4. Mise à jour du système"
    echo "A5. Création de répertoire"
    echo "A6. Suppression de répertoire"
    echo "A7. Prise de main à distance (GUI)"
    echo "A8. Définition de règles de pare-feu"
    echo "A9. Activation du pare-feu"
    echo "A10. Désactivation du pare-feu"
    echo "A11. Installation de logiciel"
    echo "A12. Désinstallation de logiciel"
    echo "A13. Exécution de script sur la machine distante"
    echo "B. Retour"
    read -p "Choisissez une action : (A1, A2, A3 etc.) " action

    case $action in
    A1) action_arret ;;
    A2) action_redemarrage ;;
    A3) action_verrouillage ;;
    A4) action_mise_a_jour ;;
    A5) action_creation_repertoire ;;
    A6) action_suppression_repertoire ;;
    A7) action_prise_de_main_distante ;;
    A8) action_definition_regles_parefeu ;;
    A9) action_activation_parefeu ;;
    A10) action_desactivation_parefeu ;;
    A11) action_installation_logiciel ;;
    A12) action_desinstallation_logiciel ;;
    A13) action_execution_script_distant ;;
    B) choix_ordinateur ;;
    *)
        echo "Option invalide. Veuillez choisir A1, A2, A3, etc."
        actions_ordinateur
        ;;
    esac
}

# Fonction pour les informations sur les utilisateurs
function informations_utilisateur {
    echo "=== Informations sur Utilisateur ==="
    echo "1. Date de dernière connexion d’un utilisateur"
    echo "2. Date de dernière modification du mot de passe"
    echo "3. Liste des sessions ouvertes par l'utilisateur"
    echo "4. Droits/permissions de l’utilisateur sur un dossier"
    echo "5. Droits/permissions de l’utilisateur sur un fichier"
    echo "6. Retour"
    read -p "Choisissez une option : (1, 2, 3, 4, 5 ou 6) " option

    case $option in
    1) Date_dernière_connexion_utilisateur ;;
    2) ;;
    3) ;;
    4) ;;
    5) ;;
    6) choix_utilisateur ;;
    *)
        echo "Option invalide. Veuillez choisir 1, 2, 3, 4, 5 ou 6."
        informations_utilisateur
        ;;
    esac
}

# Fonction pour les informations sur les ordinateurs
function informations_ordinateur {
    echo "=== Informations sur Ordinateur ==="
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
    echo "14. Retour"
    read -p "Choisissez une option : (de 1 à 14) " option

    case $option in
    1) ;;
    2) ;;
    3) ;;
    4) ;;
    5) ;;
    6) ;;
    7) ;;
    8) ;;
    9) ;;
    10) ;;
    11) ;;
    12) ;;
    13) ;;
    14) ;;
    *)
        echo "Option invalide. Veuillez choisir de 1 à 14."
        informations_ordinateur
        ;;
    esac
}

# Lancement du menu principal
while true; do
    menu_principal
done

# Actions redondantes
# Fonction d'authentification
function authentification {
    read -p "Entrez l'identifiant de la machine cible : " identifiant
    read -s -p "Entrez le mot de passe : " mot_de_passe
    echo ""
}

# Fonction de confirmation
function confirmation {
    read -p "Êtes-vous sûr de vouloir procéder ? (o/n) " confirmation
    [[ "$confirmation" != "o" ]] echo "Action annulée." && return 1
    return 0
}

# Fonction d'affichage de succès
function afficher_succes {
    echo "L'opération a réussie : $1"
}

# Fonction d'affichage d'erreur
function afficher_erreur {
    echo "L'opération a échouée : $1"
}
