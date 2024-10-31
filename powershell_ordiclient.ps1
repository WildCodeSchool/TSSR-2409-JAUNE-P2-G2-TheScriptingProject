# Menu Principal
function MenuPrincipal {
    Clear-Host
    Write-Host @"
    +===============================================+
    |  Menu Principal                               | 
    +===============================================+
    |                                               |
    |    1) Action en local                         |
    |    2) Action a distance                       |
    |    3) Information en local                    |
    |    4) Information a distance                  |
    |    5) Exit                                    |
    |                                               |
    +===============================================+
"@

    $choixMP = Read-Host "Votre choix ?"
    Switch ($choixMP) {
        "1" { MenuAction }
        "2" { MenuActionR }
        "3" { MenuInfo }
        "4" { MenuInfoR }
        "5" { Write-Host "Au revoir"
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
    |    13) Exécution de script sur la machine distante
    |    14) Retour au Menu Principal
    |    15) Exit                                         |
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
        "14" { MenuPrincipal }
        "15" { Write-Host "Au revoir"
        break }
        default { Write-Host "Option non disponible"        
        Start-Sleep -Seconds 2
        break }
    }
}
function MenuActionR {
    Clear-Host
    Write-Host @"
    +=====================================================+
    |  Menu Action                                        | 
    +=====================================================+
    |                                                     |
    |    1)  Création de compte utilisateur local         |
    |    2)  Changement de mot de passe                   |
    |    3)  Verrouillage                                 |
    |    4)  Suppression de compte utilisateur local      |
    |    5)  Désactivation de compte utilisateur local    |
    |    6)  Ajout à un groupe d'administration           |
    |    7)  Ajout à un groupe local                      |
    |    8)  Sortie d’un groupe local                     |
    |    9)  Retour au Menu Principal                     |
    |    10) Exit                                         |
    |                                                     |
    +=====================================================+
"@

    $choixMA = Read-Host "Quelle est l'Action que vous souhaitez faire ?"
    
    Switch ($choixMA) {
    # 1) Création de compte utilisateur local
        "1" { New-LocalUser }
    # 2) Changement de mot de passe
        "2" { Set-LocalUser }
            #Vérfie l'utilisateur existe (si vide alors on passe l'étape)
            #Mettre l'ancien mdp 
            #Mettre nouveau mdp
            #Confirmation nouveau mdp
            #Message erreur / changement réussi

    # 3) Verrouillage
        "3" { Disable-LocalUser }
            #Verif utilisateur existe
                #SI non -> erreur
                #SI oui ->Confirmation 
                    #commande désac
                #SI non -> erreur 
     # 4)  Suppression de compte utilisateur local
        "4" { Add-?????????GroupMember }
            #Verif utilisateur existe
            #Demande quel grp d'admin ?
                #Verif grp existe
                    #Confirmation 
                #SI non -> erreur 
    # 5)  Désactivation de compte utilisateur local
        "5" { Add-LocalGroupMember }
            #Verif utilisateur existe
                #SI non -> erreur
            #Demande quel grp local ?
                #Verif grp existe
                    #Confirmation 
                #SI non -> erreur 
    # 6)  Ajout à un groupe d'administration 
        "6" { Remove-LocalGroupMember }
            #Verif utilisateur existe
                #SI non -> erreur
            #Demande quel grp local ? liste des groupe Get-LocalGroup
                #Verif grp existe
                    #Confirmation 
                #SI non -> erreur
            # Commande sortie de grp 
                #Confirmation
                    #Msg validation
                #Msg erreur 
    # 7)  Ajout à un groupe local 

    # 8)  Sortie d’un groupe local

    
    # 9) retour au Menu principal
        "9" { MenuPrincipal }

    # 10)  Sortie d’un groupe local
        "10" { Write-Host "Au revoir"
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
    |    14) Retour au Menu Principal                     |
    |    15) Exit                                         |
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
        "15" { MenuPrincipal }
        "14" { Write-Host "Au revoir" 
        Break }
        default { Write-Host "Option non disponible"
        Start-Sleep -Seconds 2 }
    }
} 
function MenuInfoR{
    Clear-Host
    Write-Host @"
    +===========================================================+
    |  Menu Information                                         | 
    +===========================================================+
    |                                                           |
    |    1)  Date de dernière connexion d’un utilisateur        |
    |    2)  Date de dernière modification du mot de passe      |
    |    3)  Liste des sessions ouvertes par l'utilisateur      |
    |    4)  Droits/permissions de l’utilisateur sur un dossier |
    |    5)  Droits/permissions de l’utilisateur sur un fichier |
    |    6)  Retour au Menu Principal                           |
    |    7)  Exit                                               |
    |                                                           |
    +===========================================================+
    
"@

    $choixMI = Read-Host "Quelle est l'Information que vous souhaitez ?"
    Switch ($choixMI) {
        "1" {function Get-ADUserLastLogon {

            [CmdletBinding()]
            
            param(
                [Parameter(Mandatory=$false)][ValidateScript({Get-ADUser $_})]$Identity=$null
            )
        
            # Création d'un tableau vide
            $LastLogonTab = @() 
        
            # Récupérer la liste de tous les DC du domaine AD
            $DCList = Get-ADDomainController -Filter * | Sort-Object Name | Select-Object Name
        
            # Déterminer la liste des utilisateurs (un utilisateur ou tous les utilisateurs activés)
            if($Identity -eq $null){
        
                $TargetUsersList = (Get-ADUser -Filter {Enabled -eq $true}).samAccountName
            }else{
        
                $TargetUsersList = $TargetUser
            }
        
            Foreach($TargetUser in $TargetUsersList){
        
                # Initialiser le LastLogon sur $null comme point de départ
                $TargetUserLastLogon = $null
        
                Foreach($DC in $DCList){
        
                        $DCName = $DC.Name
         
                        Try {
                    
                            # Récupérer la valeur de l'attribut lastLogon à partir d'un DC (chaque DC tour à tour)
                            $LastLogonDC = Get-ADUser -Identity $TargetUser -Properties lastLogon -Server $DCName
        
                            # Convertir la valeur au format date/heure
                            $LastLogon = [Datetime]::FromFileTime($LastLogonDC.lastLogon)
        
                            # Si la valeur obtenue est plus récente que celle contenue dans $TargetUserLastLogon
                            # la variable est actualisée : ceci assure d'avoir le lastLogon le plus récent à la fin du traitement
                            If ($LastLogon -gt $TargetUserLastLogon)
                            {
                                $TargetUserLastLogon = $LastLogon
                            }
         
                            # Nettoyer la variable
                            Clear-Variable LastLogon
                            }
        
                        Catch {
                            Write-Host $_.Exception.Message -ForegroundColor Red
                        }
                }
        
                $LastLogonTab += New-Object -TypeName PSCustomObject -Property @{
                    SamAccountName = $TargetUser
                    LastLogon = $TargetUserLastLogon
                }
        
                Write-Host "lastLogon de $TargetUser : $TargetUserLastLogon"
                Clear-Variable -Name "TargetUserLastLogon"
            }
        
            return $LastLogonTab
        
        }}
        "2" {Get-LocalUser -Name "NomUtilisateur" | Select-Object Name, PasswordLastSet }
        "3" {Get-PSSession -ComputerName "localhost" }
        "4" {Get-PublicFolderClientPermission -Identity "" -User Chris | Format-List }
        "5" {"" }
        "6" {MenuPrincipal}
        "7" { Write-Host "Au revoir" 
        Break }
        default { Write-Host "Option non disponible"
        Start-Sleep -Seconds 2 }
    }
} 


# Appel initial du menu principal
MenuPrincipal
