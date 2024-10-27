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
Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version, ServicePackMajorVersion, OSArchitecture, CSName, WindowsDirectory, NumberOfUsers, BootDevice
    
    #I2 Nombre d'interface

Get-NetAdapter | fl Name, InterfaceIndex, MacAddress, MediaConnectionState, LinkSpeed

    #I3 Adresse IP de chaque interface

Get-NetIPConfiguration

    #I4 Adresse Mac

Get-NetAdapter | select ifIndex, Name, MacAddress

    #I5 Liste des applications/paquets installées

Get-AppxPackage

    #I6 Liste des utilisateurs locaux
    
Get-LocalUser

    #I7 Type de CPU, nombre de coeurs, etc.

Get-WmiObject Win32_Processor

    #I8 Mémoire RAM totale

Get-CimInstance win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Devicelocator,Capacity,Serialnumber -autosize

    #I9 Utilisation de la RAM

Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory

    #I10 Utilisation du disque

Get-PSDrive   Get-WmiObject Win32_LogicalDisk | Select SystemName,DeviceID,VolumeName,@{Name="size (Go)";Expression={"{0:N1}"-f($_.size/1GB)}},@{Name="freespace (Go)";Expression={"{0:N1}"-f($_.freespace/1GB)}} | Format-Table -GroupBy Name -AutoSize

    #I11 Utilisation du processeur

Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average

    #I12 Liste des ports ouverts
    #I13 Statut du pare-feu

Get-NetFirewallProfile
