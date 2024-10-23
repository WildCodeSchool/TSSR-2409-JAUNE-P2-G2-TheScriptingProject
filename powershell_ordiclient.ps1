#menu d'options 1 
    #Action
        #Sur cet ordi
        #Remote
    # Information 
        #Sur cet ordi
        #Remote

#Menu 2 Action
    #A1 Arrêt
    #A2 Redémarrage
    #A3 Verrouillage
    #A4 Mise-à-jour du système
    #A5 Création de répertoire
    #A6 Suppression de répertoire
    #A7 Prise de main à distance (GUI)
    #A8 Définition de règles de pare-feu
    #A9 Activation du pare-feu
    #A10 Désactivation du pare-feu
    #A11 Installation de logiciel
    #A12 Désinstallation de logiciel
    #A13 Exécution de script sur la machine distante

#Menu 2 Info 
    #I1 Version de l'OS
    Get-ComputerInfo | Select-Object WindowsVersion, OSArchitecture
    
    #I2 Nombre d'interface
    #I3 Adresse IP de chaque interface
    #I4 Adresse Mac
    #I5 Liste des applications/paquets installées
    #I6 Liste des utilisateurs locaux
    #I7 Type de CPU, nombre de coeurs, etc.
    #I8 Mémoire RAM totale
    #I9 Utilisation de la RAM
    #I10 Utilisation du disque
    #I11 Utilisation du processeur
    #I12 Liste des ports ouverts
    #I13 Statut du pare-feu
