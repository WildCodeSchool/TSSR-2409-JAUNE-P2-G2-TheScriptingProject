#menu Principal

function Menuprincipal{
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
Read-Host "Votre choix ?"          
}

 #Menu Action           
function MenuAction{
    Clear-Host
    Write-Host @"
    +=====================================================+
    |  Menu Action                                        | 
    +=====================================================+
    |                                                     |
    |    1)  Arret                                        |
    |    2)  Redémarrage                                  |
    |    3)  Verrouillage                                 |
    |    4)  Mise a jour Système                          |
    |    5)  Création de répertoire                       |
    |    6)  Suppression de répertoire                    |
    |    7)  Prise de main à distance                     |
    |    8)  Définition de règles de pare-feu             |
    |    9)  Activation du pare-feu                       |
    |    10) Désactivation du Pare-feu                    |
    |    11) Installation de logiciel                     |
    |    12) Désinstallation de logiciel                  |
    |    13) Exécution de script sur la machine distante  |
    |    14) Exit                                         |
    +=====================================================+
    
"@
    
Read-Host "Quelle est l'Action que vous souhaitez faire ?"
}
#Sur cet ordi  A FAIRE 
#Remote    A FAIRE


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
    
Read-Host "Quelle est l'Information que vous souhaitez ?"
} 

#Sur cet ordi  A FAIRE 
#Remote    A FAIRE

$choixMP = Menuprincipal
Switch ($choixMP)
# Launch menu action       
 {
        "1" { $choixMA = MenuAction
        }
# Lauch menu Information        
        "2" { $choixMI =  MenuInfo     
        }   
# OPTION3 - EXIT        
        "3" { $choixMP3 =  
        Write-Host "Au revoir"
        Break
        }
        default {
        #DEFAULT OPTION
        Write-Host "Option not available"
        Start-Sleep -Seconds 1
        }
 }

$choixMA = MenuAction
Switch ($choixMA)      
 {
    #A1 Arrêt
    "1" { $choixMA1 = Stop-Computer -ComputerName "localhost"  
    }
    #A2 Redémarrage
    "2" { $choixMA2 = Restart-Computer -ComputerName "localhost" 
    }
    #A3 Verrouillage
    "3" { $choixMA3 = "" 
       
    }
    #A4 Mise-à-jour du système   
    "4" { $choixMA4 = Install-WUUpdates    
    }
    #A5 Création de répertoire
    "5" { $choixMA5 = New-Item -Name "" -ItemType "Directory"  
    }
    #A6 Suppression de répertoire
    "6" { $choixMA6 = Remove-item -Name "" -ItemType ""
    }
    #A7 Prise de main à distance (GUI)
    "7" { $choixMA7 = Write-Host "Lancement de connexion a distance"
            $start_cad = "mstsc"
            Start-Process $start_cad 
         }
    #A8 Définition de règles de pare-feu   
    "8" { $choixMA8 = Get-NetFirewallProfile | ft Name,Enabled    
    }
    #A9 Activation du pare-feu
    "9" { $choixMA9 = Set-NetFirewallProfile -Profile ",Public,Private" -Enabled False   
    }
    #A10 Désactivation du pare-feu
    "10" { $choixMA10 = Set-NetFirewallProfile -Profile ou Public ou * -Enabled true 
    } 
    #A11 Installation de logiciel 
    "11" { $choixMA11 = Install-Package    
    } 
    #A12 Désinstallation de logiciel
    "12" { $choixMA12 = Uninstall-Package  
    }
    #13Exécution de script sur la machine distante
    "13" { $choixMA13 = ""
    }
    "14" {   
    Write-Host "Au revoir"
    Break
    }
    default {
    #DEFAULT OPTION
    Write-Host "Option not available"
    Start-Sleep -Seconds 1
    }
 }

$choixMI = MenuInfo
Switch ($choixMI)      
 {
    #I1 Version de l'OS
    "1" { $choixMI1 = Get-ComputerInfo | Select-Object WindowsVersion, OSArchitecture
    #Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version, ServicePackMajorVersion, OSArchitecture, CSName, WindowsDirectory, NumberOfUsers, BootDevice
    }
    #I2 Nombre d'interface   
    "2" { $choixMI2 = Get-NetAdapter | fl Name, InterfaceIndex, MacAddress, MediaConnectionState, LinkSpeed   
    }
    #I3 Adresse IP de chaque interface
    "3" { $choixMI3 = Get-NetIPConfiguration
    }
    #I4 Adresse Mac   
    "4" { $choixMI4 = Get-NetAdapter | select ifIndex, Name, MacAddress     
    }
    #I5 Liste des applications/paquets installées
    "5" { $choixMI5 = Get-AppxPackage 
    }
    #I6 Liste des utilisateurs locaux   
    "6" { $choixMI6 = Get-LocalUser 
    }
    #I7 Type de CPU, nombre de coeurs, etc.
    "7" { $choixMI7 =Get-WmiObject Win32_Processor
    }  
    #I8 Mémoire RAM totale
    "8" { $choixMI8 =Get-CimInstance win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Devicelocator,Capacity,Serialnumber -autosize  
    }
    #I9 Utilisation de la RAM
    "9" { $choixMI9 = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory
    }  
    #I10 Utilisation du disque
    "10" { $choixMI10 = Get-PSDrive   Get-WmiObject Win32_LogicalDisk | Select SystemName,DeviceID,VolumeName,@{Name="size (Go)";Expression={"{0:N1}"-f($_.size/1GB)}},@{Name="freespace (Go)";Expression={"{0:N1}"-f($_.freespace/1GB)}} | Format-Table -GroupBy Name -AutoSize
    }
    #I11 Utilisation du processeur 
    "11" { $choixMI11 = Get-WmiObject Win32_Processor | Measure-Object -Property (LoadPercentage -Average).Average     
    } 
    #I12 Liste des ports ouverts
    "12" { $choixMI12 = ""    
    }
    #I13 Statut du pare-feu
    "13" { $choixMI13 = Get-NetFirewallProfile
    } 
    #Exit
    "14" {   
    Write-Host "Au revoir"
    Break
    }
    default {
    #DEFAULT OPTION
    Write-Host "Option not available"
    Start-Sleep -Seconds 1
    }
 }   

