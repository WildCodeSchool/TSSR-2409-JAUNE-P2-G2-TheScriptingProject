#menu d'options 1 
    #Action
        #Sur cet ordi
        #Remote
    # Information 
        #Sur cet ordi
        #Remote

#Menu 2 Action
    #A1 Arrêt
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Envoyer l'odre d'arrêt système
    #A2 Redémarrage
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Envoyer l'ordre de redémarrage système
    #A3 Verrouillage
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Envoyer l'ordre de redémarrage système
    #A4 Mise-à-jour du système
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Commande sudo apt update upgrade 
        # Msg erreur/réussie
        # Se déconnecter
    #A5 Création de répertoire
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le chemin de création du répertoire
        # Confirmation
        # Création et cd dans le dossier 
        # Msg erreur/réussi
    #A6 Suppression de répertoire
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le chemin du répertoire à supprimer
        # Confirmation 
        # Msg erreur/réussi
    #A7 Prise de main à distance (GUI) ???
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
    #A8 Définition de règles de pare-feu
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Commande avec iptables ? ufw ? 
    #A9 Activation du pare-feu
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Commande avec iptables ? ufw ? 
    #A10 Désactivation du pare-feu
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Commande avec iptables ? ufw ? 
    #A11 Installation de logiciel
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le nom du logiciel 
        # Confirmation ?
        # Test installation 
            # Si oui -> succès
            # Si non -> erreur 
    #A12 Désinstallation de logiciel
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le nom du logiciel 
        # Confirmation 
        # Test désinstallation 
            #Si oui -> succès 
            #Si non -> erreur 
    #A13 Exécution de script sur la machine distante
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander emplacement du script 
#Menu 2 Info 
    #I1 Version de l'OS
        cat /etc/os-release | grep PRETTY_NAME
    
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        # Commande bash 
    #I2 Nombre d'interface
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        # Commande /etc/network/interfaces  grep expression + nbr de lignes
    #I3 Adresse IP de chaque interface
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        #Commande grep /etc/network/interfaces
    #I4 Adresse Mac
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        #Confirmer la machine ? 
        # Grep le fichier des addresses MAC 
    #I5 Liste des applications/paquets installées
    #I6 Liste des utilisateurs locaux
    #I7 Type de CPU, nombre de coeurs, etc.
    #I8 Mémoire RAM totale
    #I9 Utilisation de la RAM
    #I10 Utilisation du disque
    #I11 Utilisation du processeur
    #I12 Liste des ports ouverts
    #I13 Statut du pare-feu
