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
        shutdown now
    #A2 Redémarrage
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        reboot
    #A3 Verrouillage
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        logout
    #A4 Mise-à-jour du système
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        sudo apt update && sudo apt upgrade -y
        # Msg erreur/réussie
        # Se déconnecter
    #A5 Création de répertoire
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le chemin de création du répertoire
        # Confirmation
        mkdir $... && cd $...
        # Msg erreur/réussi
    #A6 Suppression de répertoire
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le chemin du répertoire à supprimer
        # Confirmation
        rm -r $...
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
        sudo ufw enable
        iptable ??
    #A10 Désactivation du pare-feu
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        sudo ufw disable
    #A11 Installation de logiciel
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le nom du logiciel 
        # Confirmation ?
        sudo apt install $... -y
            # Si oui -> succès
            # Si non -> erreur 
    #A12 Désinstallation de logiciel
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander le nom du logiciel 
        # Confirmation 
        sudo apt remove $... -y  
            #Si oui -> succès 
            #Si non -> erreur 
    #A13 Exécution de script sur la machine distante
        # Demander les identifiants pour la machine cible
        # Se connecter 
        # Message erreur / succes
        # Demander emplacement du script 
#Menu 2 Info 
    #I1 Version de l'OS
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        cat /etc/os-release | grep PRETTY_NAME 
    #I2 Nombre d'interface
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        cat /etc/network/interfaces | grep enp*  
    #I3 Adresse IP de chaque interface
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        cat /etc/network/interfaces | grep
    #I4 Adresse Mac
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        #Confirmer la machine ?
        # commande
        ip a | grep ether
    #I5 Liste des applications/paquets installées
        # Demander les identifiants pour la machine cible
        # Se connecter
        apt list --installed 
        # Message erreur / succes
    #I6 Liste des utilisateurs locaux
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        cat /etc/passwd | grep /home 
    #I7 Type de CPU, nombre de coeurs, etc.
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        cat /proc/cpuinfo
    #I8 Mémoire RAM totale
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        cat /proc/meminfo
    #I9 Utilisation de la RAM
        # Demander les identifiants pour la machine cible
        # Se connecter
        # Message erreur / succes
        cat /proc/meminfo | grep MemFree
    #I10 Utilisation du disque
    #I11 Utilisation du processeur
    #I12 Liste des ports ouverts
    #I13 Statut du pare-feu
