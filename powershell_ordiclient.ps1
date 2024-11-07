# Menu Principal

function MenuPrincipal {
    #Clear-Host
    Write-Host @"
        +===============================================+
        |  Choisir une Cible                            |
        +===============================================+
        |                                               |
        |    1) Utilisateur                             |
        |    2) Ordinateur                              |
        |    Q) Quitter                                 |
        |                                               |
        +===============================================+
"@


    $choixMP = Read-Host -Prompt "Votre choix ?"
    Switch ($choixMP) {
        "1" { choix_utilisateur }
        "2" { choix_ordinateur }
        "Q" {Write-Host "Au revoir"
            exit }
        default {
            Write-Host "Option non disponible"-ForegroundColor Red
            Start-Sleep -Seconds 2
            MenuPrincipal
        }
    }
}

function choix_utilisateur {
    #Clear-Host
    Write-Host @"
        +===============================================+
        |  Actions ou Informations sur Utilisateur      |
        +===============================================+
        |                                               |
        |    1) Actions                                 |
        |    2) Informations                            |
        |    R) Retour au menu principal                |
        |    Q) Quitter                                 |
        |                                               |
        +===============================================+
"@


    $choixU = Read-Host -Prompt "Votre choix ?"
    Switch ($choixU) {
        "1" { actions_utilisateur }
        "2" { informations_utilisateur }
        "R" { MenuPrincipal }
        "Q" {
            Write-Host "Au revoir"
            exit 
        }
        default {
            Write-Host "Option non disponible"-ForegroundColor Red
            Start-Sleep -Seconds 2
            MenuPrincipal
        }
    }
}

function choix_ordinateur {
    #Clear-Host
    Write-Host @"
        +===============================================+
        |  Actions ou Informations sur ordinateurs      |
        +===============================================+
        |                                               |
        |    1) Actions                                 |
        |    2) Informations                            |
        |    R) Retour au menu principal                |
        |    Q) Quitter                                 |
        |                                               |
        +===============================================+
"@


    $choixO = Read-Host -Prompt "Votre choix ?"
    Switch ($choixO) {
        "1" { actions_ordinateur }
        "2" { informations_ordinateur }
        "R" { MenuPrincipal }
        "Q" {
            Write-Host "Au revoir"
            exit 
        }
        default {
            Write-Host "Option non disponible"-ForegroundColor Red
            Start-Sleep -Seconds 2
            MenuPrincipal
        }
    }
}
# Menu Action
function actions_ordinateur {
    #Clear-Host
    Write-Host @"
        +=====================================================+
        |  Actions sur Ordinateur                             |
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
        |    R)  Retour au Menu Principal                     |
        |    Q)  Quitter                                      |
        |                                                     |
        +=====================================================+

"@

    $choixAO = Read-Host -Prompt "Quelle est l'Action que vous souhaitez faire ?"
    Switch ($choixAO) {
        "1" { $User = Read-Host -Prompt "Quel est le nom de l'ordinateur a arreter"
            Stop-Computer -ComputerName $User } 
        "2" { $User1 = Read-Host -Prompt "Quel est l'ordinateur a redemarrer"
            Restart-Computer -ComputerName $User1 } 
        "3" { rundll32.exe user32.dll,LockWorkStation }
        "4" { Install-WUUpdates }
        "5" { $newdossier = Read-Host -Prompt "quel est le mon de votre dossier"
        $chemin = Read-Host -Prompt "Emplecement du nouveau dossier"
        New-Item -path $chemin -Name $newdossier -ItemType "Directory" }
        "6" { $dossier = Read-Host -Prompt "quel est le mon de votre dossier a supprimer"
        $chemin1 = Read-Host -Prompt "Emplecement du nouveau dossier"
        Remove-Item -path $chemin1 -Name $dossier -ItemType "Directory" }
        "7" {
            Write-Host "Lancement de connexion à distance" 
            Start-Process "mstsc" 
        }
        "8" { Get-NetFirewallProfile | Format-Table Name, Enabled }
            #Write-Host $choixAO8 }
        "9" { Set-NetFirewallProfile -Profile "Public,Private" -Enabled $true }
        "10" { Set-NetFirewallProfile -Profile "Public" -Enabled $false }
        "11" { Install-Package (Read-Host -Prompt "Nom du logiciel") }
        "12" { Uninstall-Package (Read-Host -Prompt "Nom du logiciel") }
        "13" { $choixAO13 = read-host "Quel script souhaitez-vous executer ?"  
        invoke-Command -ComputerName 172.16.20.20 -FilePath "$ChoixAO13" }
        "R" { MenuPrincipal }
        "Q" {exit
            Write-Host "Au revoir"
            exit 
        }
        default {
            Write-Host "Option non disponible"        
            Start-Sleep -Seconds 2
            break 
        }
    }
}
# Menu Action a Distance
function actions_utilisateur {
    #Clear-Host
    Write-Host @"
        +=====================================================+
        |  Actions sur Utilisateur                            | 
        +=====================================================+
        |                                                     |
        |    1)  Création de compte                           |
        |    2)  Changement de mot de passe                   |
        |    3)  Suppression de compte                        |
        |    4)  Désactivation de compte                      |
        |    5)  Ajout à un groupe d'administration           |
        |    6)  Ajout à un groupe local                      |
        |    7)  Sortie d’un groupe local                     |
        |    R)  Retour au Menu Principal                     |
        |    Q)  Quitter                                      |
        |                                                     |
        +=====================================================+

"@

    $choixAU = Read-Host -Prompt "Quelle est l'Action que vous souhaitez faire ?"
    
    Switch ($choixAU) {
        # 1) Création de compte utilisateur local
        "1" { New-LocalUser }
        # 2) Changement de mot de passe
        "2" { Set-LocalUser }
        #Vérfie l'utilisateur existe (si vide alors on passe l'étape)
        #Mettre l'ancien mdp 
        #Mettre nouveau mdp
        #Confirmation nouveau mdp
        #Message erreur / changement réussi

        # 3)  Suppression de compte utilisateur local
        "3" { Add-?????????GroupMember }
        #Verif utilisateur existe
        #Demande quel grp d'admin ?
        #Verif grp existe
        #Confirmation 
        #SI non -> erreur 
        # 4)  Désactivation de compte utilisateur local
        "4" { Add-LocalGroupMember }
        #Verif utilisateur existe
        #SI non -> erreur
        #Demande quel grp local ?
        #Verif grp existe
        #Confirmation 
        #SI non -> erreur 
        # 5)  Ajout à un groupe d'administration 
        "5" { Remove-LocalGroupMember }
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
        # 6)  Ajout à un groupe local 

        # 7)  Sortie d’un groupe local

        
        # R) retour au Menu principal
        "R" { MenuPrincipal }

        # Q)  Sortie d’un groupe local
        "Q" {
            Write-Host "Au revoir"
            exit 
        }
        default {
            Write-Host "Option non disponible"        
            Start-Sleep -Seconds 2
            break 
        } 
    }
}

# Menu Information
function informations_ordinateur {
    #Clear-Host
    Write-Host @"
        +=====================================================+
        |  Informations sur Ordinateur                        |
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
        |    R)  Retour au Menu Principal                     |
        |    Q)  Quitter                                      |
        |                                                     |
        +=====================================================+
    
"@

    $choixIO = Read-Host -Prompt "Quelle est l'Information que vous souhaitez ?"
    Switch ($choixIO) {
        "1" { Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version, ServicePackMajorVersion, OSArchitecture, CSName, WindowsDirectory, NumberOfUsers, BootDevice | Out-String |
            write-host }
        "2" { Get-NetAdapter | Format-List Name, InterfaceIndex, MacAddress, MediaConnectionState, LinkSpeed | Out-String |
            Write-host }
        "3" { Get-NetIPConfiguration | Out-String | write-host }
        "4" { Get-NetAdapter | Select-Object Index, Name, MacAddress | Out-String | write-host} 
        "5" { $choixIO5 = Get-AppxPackage |
            Write-Host $choixIO5}# ne fonctionne pas
        "6" { Get-LocalUser | Out-String | write-host }
        "7" { Get-WmiObject Win32_Processor | Out-String | write-host } 
        "8" { Get-CimInstance win32_physicalmemory | Format-Table Manufacturer, Banklabel, Configuredclockspeed, Devicelocator, Capacity, Serialnumber -autosize | Out-String | write-host }
        "9" { $totalMemory = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory 
            $totalMemoryMB = [math]::round($totalMemory / 1Mb )
            Write-Host $totalMemoryMB }  
        "10" { $choixIO10 = Get-PSDrive 
            Write-Host $choixIO10}
        "11" { Get-CimInstance win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object Average | Out-String | write-host }
        "12" { "" }
        "13" { Get-NetFirewallProfile | Out-String | write-host } 
        "R" { MenuPrincipal }
        "Q" {
            Write-Host "Au revoir" 
            exit 
        }
        default {
            Write-Host "Option non disponible"
            Start-Sleep -Seconds 2 
        }
    }
}
# Menu Information a distance
function informations_utilisateur {
    #Clear-Host
    Write-Host @"
        +===========================================================+
        |  Informations sur Utilisateur                             |
        +===========================================================+
        |                                                           |
        |    1)  Date de dernière connexion d’un utilisateur        |
        |    2)  Date de dernière modification du mot de passe      |
        |    3)  Liste des sessions ouvertes par l'utilisateur      |
        |    4)  Droits/permissions de l’utilisateur sur un dossier |
        |    5)  Droits/permissions de l’utilisateur sur un fichier |
        |    R)  Retour au Menu Principal                           |
        |    Q)  Quitter                                            |
        |                                                           |
        +===========================================================+
        
"@

    $choixIU = Read-Host -Prompt "Quelle est l'Information que vous souhaitez ?"
    Switch ($choixIU) {
        "1" {
            function Get-ADUserLastLogon {
                [CmdletBinding()]
                
                param(
                    [Parameter(Mandatory = $false)][ValidateScript({ Get-ADUser $_ })]$Identity = $null
                )
            
                # Création d'un tableau vide
                $LastLogonTab = @() 
            
                # Récupérer la liste de tous les DC du domaine AD
                $DCList = Get-ADDomainController -Filter * | Sort-Object Name | Select-Object Name
            
                # Déterminer la liste des utilisateurs (un utilisateur ou tous les utilisateurs activés)
                if ($Identity -eq $null) {
            
                    $TargetUsersList = (Get-ADUser -Filter { Enabled -eq $true }).samAccountName
                }
                else {
            
                    $TargetUsersList = $TargetUser
                }
            
                Foreach ($TargetUser in $TargetUsersList) {
            
                    # Initialiser le LastLogon sur $null comme point de départ
                    $TargetUserLastLogon = $null
            
                    Foreach ($DC in $DCList) {
            
                        $DCName = $DC.Name
                        Try {
                            # Récupérer la valeur de l'attribut lastLogon à partir d'un DC (chaque DC tour à tour)
                            $LastLogonDC = Get-ADUser -Identity $TargetUser -Properties lastLogon -Server $DCName
                            # Convertir la valeur au format date/heure
                            $LastLogon = [Datetime]::FromFileTime($LastLogonDC.lastLogon)
                            # Si la valeur obtenue est plus récente que celle contenue dans $TargetUserLastLogon
                            # la variable est actualisée : ceci assure d'avoir le lastLogon le plus récent à la fin du traitement
                            If ($LastLogon -gt $TargetUserLastLogon) {
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
                        LastLogon      = $TargetUserLastLogon
                    }
                    Write-Host "lastLogon de $TargetUser : $TargetUserLastLogon"
                    Clear-Variable -Name "TargetUserLastLogon"
                }
                return $LastLogonTab
            }
        }
        "2" { Get-LocalUser -Name "NomUtilisateur" | Select-Object Name, PasswordLastSet }
        "3" { Get-PSSession -ComputerName "localhost" }
        "4" { Get-PublicFolderClientPermission -Identity "" -User Chris | Format-List }
        "5" { "" }
        "R" { MenuPrincipal }
        "Q" {
            Write-Host "Au revoir" 
            exit 
        }
        default {
            Write-Host "Option non disponible"
            Start-Sleep -Seconds 2 
        }
    }
} 

function connection {
    $connect = read-host "a quel ordinateur souhaitez-vous vous connecter ?"
    Enter-Pssession -CoputerName $connect -Credential "Administrator"
}
function deconnection {
    Exit-PSsession
}
# Appel initial du menu principal
do {
    $choiceMP= MenuPrincipal
} while ( $choiceMP -ne "Q"
    <# Condition that stops the loop if it returns false #>
)
