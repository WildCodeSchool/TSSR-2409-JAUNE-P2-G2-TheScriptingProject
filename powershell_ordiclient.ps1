#menu d'options 1 
    #Action
        #Sur cet ordi
        #Remote
    # Information 
        #Sur cet ordi
        #Remote

#Menu 2 Action
    #A1 Arrêt
Stop-Computer -ComputerName , "localhost"
    #A2 Redémarrage
Restart-Computer -ComputerName , localhost
    #A3 Verrouillage

    #A4 Mise-à-jour du système
Install-WUUpdates
    #A5 Création de répertoire
New-Item -Name "PowerShell" -ItemType Directory
    #A6 Suppression de répertoire
Remove-item
    #A7 Prise de main à distance (GUI)
Write-Host "Lancement de connexion a distance"
        $start_cad = "mstsc"
        Start-Process $start_cad
    #A8 Définition de règles de pare-feu
Get-NetFirewallProfile | ft Name,Enabled
    #A9 Activation du pare-feu
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
    #A10 Désactivation du pare-feu
Set-NetFirewallProfile -Profile ou Public ou * -Enabled true
    #A11 Installation de logiciel
Install-Package
    #A12 Désinstallation de logiciel
Uninstall-Package
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
