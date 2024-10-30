# Menu Principal
function MenuPrincipal {
    Clear-Host
    Write-Host @"
    +===============================================+
    |  Menu Principal                               | 
    +===============================================+
    |                                               |
    |    1) Action                                  |
    |    2) Information                             |
    |    3) Exit                                    |
    +===============================================+
"@

    $choixMP = Read-Host "Votre choix ?"
    Switch ($choixMP) {
        "1" { MenuAction }
        "2" { MenuInfo }
        "3" { Write-Host "Au revoir"
            break }
        default { Write-Host "Option non disponible"
            Start-Sleep -Seconds 2
            MenuPrincipal
        }
    }
}

# Menu Action
function MenuAction {
    Clear-Host
    Write-Host @"
    +=====================================================+
    |  Menu Action                                        | 
    +=====================================================+
    |                                                     |
    |    1)  Arrêt                                        |
    |    2)  Redémarrage                                  |
    |    3)  Verrouillage                                 |
    |    4)  Mise à jour Système                          |
    |    5)  Création de répertoire                       |
    |    6)  Suppression de répertoire                    |
    |    7)  Prise de main à distance                     |
    |    8)  Définition de règles de pare-feu             |
    |    9)  Activation du pare-feu                       |
    |    10) Désactivation du pare-feu                    |
    |    11) Installation de logiciel                     |
    |    12) Désinstallation de logiciel                  |
    |    13) Exécution de script sur la machine distante  |
    |    14) Exit                                         |
    +=====================================================+
"@

    $choixMA = Read-Host "Quelle est l'Action que vous souhaitez faire ?"
    
    Switch ($choixMA) {
        "1" { Stop-Computer -ComputerName "localhost" }
        "2" { Restart-Computer -ComputerName "localhost" }
        "3" { Write-Host "Verrouillage (à définir)" }
        "4" { Install-WUUpdates }
        "5" { New-Item -Name (Read-Host "Nom du répertoire") -ItemType "Directory" }
        "6" { Remove-Item -Path (Read-Host "Nom du répertoire") -Recurse }
        "7" { Write-Host "Lancement de connexion à distance" 
        Start-Process "mstsc" }
        "8" { Get-NetFirewallProfile | Format-Table Name, Enabled }
        "9" { Set-NetFirewallProfile -Profile "Public,Private" -Enabled $true }
        "10" { Set-NetFirewallProfile -Profile "Public" -Enabled $false }
        "11" { Install-Package (Read-Host "Nom du logiciel") }
        "12" { Uninstall-Package (Read-Host "Nom du logiciel") }
        "13" { Write-Host "Exécution de script à distance (à définir)" }
        "14" { Write-Host "Au revoir"
        break }
        default { Write-Host "Option non disponible"        
        Start-Sleep -Seconds 2
        break }
    }
}

# Menu Information
function MenuInfo{
    Clear-Host
    Write-Host @"
    +=====================================================+
    |  Menu Information                                   | 
    +=====================================================+
    |                                                     |
    |    1)  Version de l'OS                              |
    |    2)  Nombre d'interface                           |
    |    3)  Adresse IP de chaque interface               |
    |    4)  Adresse Mac                                  |
    |    5)  Liste des applications/paquets               |
    |        installées de répertoire                     |
    |    6)  Liste des utilisateurs locaux                |
    |    7)  Type de CPU, nombre de coeurs, etc.          |
    |    8)  Mémoire RAM totale                           |
    |    9)  Utilisation de la RAM                        |
    |    10) Utilisation du disque                        |
    |    11) Utilisation du processeur                    |
    |    12) Liste des ports ouverts                      |
    |    13) Statut du pare-feu                           |
    |    14) Exit                                         |
    |                                                     |
    +=====================================================+
    
"@

    $choixMI = Read-Host "Quelle est l'Information que vous souhaitez ?"
    Switch ($choixMI) {
        "1" {Get-ComputerInfo | Select-Object WindowsVersion, OSArchitecture}
        "2" {Get-NetAdapter | fl Name, InterfaceIndex, MacAddress, MediaConnectionState, LinkSpeed }
        "3" {Get-NetIPConfiguration }
        "4" {Get-NetAdapter | select ifIndex, Name, MacAddress }
        "5" {Get-AppxPackage }
        "6" {Get-LocalUser  }
        "7" {Get-WmiObject Win32_Processor }  
        "8" {Get-CimInstance win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Devicelocator,Capacity,Serialnumber -autosize   }
        "9" {Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory }  
        "10" {Get-PSDrive}
        "11" {Get-WmiObject Win32_Processor | Measure-Object -Property (LoadPercentage -Average).Average} 
        "12" {""     }
        "13" {Get-NetFirewallProfile } 
        "14" { Write-Host "Au revoir" 
        Break }
        default { Write-Host "Option non disponible"
        Start-Sleep -Seconds 2 }
    }
} 

# Appel initial du menu principal
MenuPrincipal
