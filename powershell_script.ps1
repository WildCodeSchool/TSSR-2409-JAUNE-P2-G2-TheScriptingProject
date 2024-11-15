
# Log 
function start_log {
    $Logfile = "C:\Windows\System32\LogFiles\"
    if (!(Test-path -Path "$logfile")) {
        New-Item -Path "$logfile" -ItemType File -Name "log_evt.log" -Force
        $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
        $User = $env:USERNAME
        Add-Content $Logfile -Value "$stamp - $user-********StartScript********"
    }
    else {
        $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
        $User = $env:USERNAME
        Add-Content -Path "$Logfile\log_evt.log" -Value "$stamp - $user-********StartScript********"
    }
                
}
        
function WriteLog {
    #$Logfile = "C:\Windows\System32\LogFiles\log_evt.log"
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $User = $env:Username
    $LogMessage = "$Stamp - $User - $LogString"
    Add-content "$LogFile" -value $LogMessage
}
# log info 
function log_info {
    Param ($LogString)
    $Stamp = (Get-Date).toString("yyyy/MM/dd")
    $User = $env:Username
    $log_path = "C:\Users\$user\Documents"
    $Log_file = "C:\Users\$user\Documents\info-$user-$stamp.txt"
    New-Item -Path "$log_path" -ItemType File -Name "info-$user-$stamp.txt" -Force
    $LogMessage = "$LogString `n ------------------------------------"
    Add-content $LogFile -value $LogMessage
}

# condition d'arguments pour enregistrement
# stocké dans une focntion car besoin plus tard mais ça va être delete     
# Appel des logs
start_log
$Logfile = "C:\Windows\System32\LogFiles\log_evt.log"
# Menu Principal

function MenuPrincipal {
    try {
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
            "1" {
                WriteLog "Vous avez selectionné : choix_utilisateur "
                choix_utilisateur
            }
            "2" {
                WriteLog "Vous avez selectionné : choix_ordinateur" 
                choix_ordinateur
        
            }
            "Q" {
                WriteLog "Vous avez quitté : Menu_principal"
                Write-Host "Au revoir"
                exit 
            }
            default {
                WriteLog "Option non disponible, retour vers : Menu_principal"
                Write-Host "Option non disponible"-ForegroundColor Red
                Start-Sleep -Seconds 2
                MenuPrincipal
            
            }
        }
    }
    catch {
        Write-Output "ATTENTION : Une erreur a été capturée : $($_.Exception.Message)"
    }
}
function choix_utilisateur {
    try {
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
            "1" {
                WriteLog "Vous avez selectionné : actions_utilisateur "
                actions_utilisateur 
            }
            "2" {
                WriteLog "Vous avez selectionné : informations_utilisateur "
                informations_utilisateur 
            }
            "R" {
                WriteLog "Vous avez selectionné : MenuPrincipal "
                MenuPrincipal 
            }
            "Q" {
                WriteLog "Vous avez quitté : Menu_principal"
                Write-Host "Au revoir"
                exit 
            }
            default {
                WriteLog "Option non disponible, retour vers : MenuPrincipal "
                Write-Host "Option non disponible"-ForegroundColor Red
                Start-Sleep -Seconds 2
                MenuPrincipal
            }
        }
    }
    catch {
        Write-Output "ATTENTION : Une erreur a été capturée : $($_.Exception.Message)"
    }
}

function choix_ordinateur {
    try {
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
            "1" {
                WriteLog "Vous avez selectionné : actions_ordinateur " 
                actions_ordinateur 
            }
            "2" {
                WriteLog "Vous avez selectionné : informations_ordinateur "
                informations_ordinateur 
            }
            "R" {
                WriteLog "Vous avez selectionné : MenuPrincipal "
                MenuPrincipal 
            }
            "Q" {
                WriteLog "Vous avez quitté : Choix_ordinateur"
                Write-Host "Au revoir"
                exit 
            }
            default {
                WriteLog "Option non disponible, retour vers : MenuPrincipal "
                Write-Host "Option non disponible"-ForegroundColor Red
                Start-Sleep -Seconds 2
                MenuPrincipal
            }
        }
    }
    catch {
        Write-Output "ATTENTION : Une erreur a été capturée : $($_.Exception.Message)"
    }
}
# Menu Action
function actions_ordinateur {
    try {
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

        $choixAO = Read-Host -Prompt "Quelle est l'action que vous souhaitez faire ?"
        Switch ($choixAO) {
            "1" {
                WriteLog "Vous avez selectionné l'action : Arrêt"
                $choixAO1 = Read-Host -Prompt "Quel est le nom de l'ordinateur a arreter"
                Stop-Computer -ComputerName $choixAO1 -Force -Credential (get-Credential)
            } 
            "2" {
                WriteLog "Vous avez selectionné l'action : Redémarrage"
                $choixAO2 = Read-Host -Prompt "Quel est l'ordinateur a redemarrer" 
                Restart-Computer -ComputerName $choixAO2 -Force -Credential (get-Credential)
            }
            "3" {
                WriteLog "Vous avez selectionné l'action : Verrouillage"
                $choixAO3 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
                $username = Read-Host -Prompt "Entrez le nom d'utilisateur à verrouiller :"
    
                Invoke-Command -ComputerName $choixAO3 -ScriptBlock {
                    # Liste les sessions
                    $sessions = query user | Select-Object -Skip 1  # Ignore la première ligne d'en-tête
        
                    # Filtrer les sessions correspondant à l'utilisateur
                    $sessions | Where-Object { $_ -match $using:username } | ForEach-Object {
                        # Diviser la ligne par espaces et récupérer l'ID de session
                        $sessionInfo = $_ -split '\s+'
                        $sessionId = $sessionInfo[2]
                        logoff $sessionId
                    }
                }
            }
            # Demande à l'utilisateur de choisir l'ordinateur à mettre à jour
            "4" {
                WriteLog "Vous avez selectionné l'action : Mise à jour système"
                $choixAO4 = Read-Host -Prompt "Quel est l'ordinateur à mettre à jour ?"
                # Vérification de l'accès à distance via WinRM
                if (Test-Connection -ComputerName $choixAO4 -Count 1 -Quiet) {
                    try {
                        # Installation des mises à jour via PSWindowsUpdate
                        Invoke-Command -ComputerName $choixAO4 -ScriptBlock {
                            # Vérifier si le module PSWindowsUpdate est installé
                            if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
                                Write-Output "Le module PSWindowsUpdate n'est pas installé. Installation en cours..."
                                Install-Module -Name PSWindowsUpdate -Force -AllowClobber
                            }
                            # Importer le module et exécuter les mises à jour
                            Import-Module PSWindowsUpdate
                            Write-Output "Installation des mises à jour en cours..."
                            Install-WindowsUpdate -AcceptAll -AutoReboot -Verbose
                        } -Credential (Get-Credential)
                    }
                    catch {
                        Write-Output "Une erreur est survenue lors de la connexion ou de l'installation des mises à jour : $_"
                    }
                }
                else {
                    Write-Output "L'ordinateur $choixAO4 est injoignable. Veuillez vérifier le nom ou la connexion réseau."
                }
            }
        
            "5" {
                WriteLog "Vous avez selectionné l'action : Création de répertoire"
                # Création de dossier
                $Newdossier = Read-Host "Quel dossier souhaitez-vous créer ?" 
                $choixAU1 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU1 -ArgumentList $Newdossier -ScriptBlock {
                    param($Newdossier)
                    $condition = get-Item "$Newdossier"-ErrorAction SilentlyContinue
                    if (-not $condition) {
                        $params = @{
                            Name = $Newdossier
                    
                        }
                        New-item @params -Confirm -itemtype Directory
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : Le dossier existe déjà"
                    } 
                }
            }
            "6" {
                WriteLog "Vous avez selectionné l'action : Suppression de répertoire"
                # Suppression de dossier
                $dossier = Read-Host "Quel dossier souhaitez-vous supprimer ?" 
                $choixAU1 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU1 -ArgumentList $dossier -ScriptBlock {
                    param($dossier)
                    $condition = get-Item "$dossier"-ErrorAction SilentlyContinue
                    if ($condition) {
                        Remove-item "$dossier" -Confirm
                        Write-host "Action réussie"  
                    }
                    else {
                        Write-host "Erreur : Le dossier n'existe pas"
                    }
                }
            }
            "7" {
                WriteLog "Vous avez selectionné l'action : Prise de main à distance"
                Write-Host "Lancement de connexion à distance" 
                Start-Process "mstsc"
            }
        
            "8" {
                WriteLog "Vous avez selectionné l'action : Définition de règles de pare-feu "
                $choixA08 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
                $nom_regle = Read-Host -Prompt "Nommez votre nouvelle règle"
                $direction = Read-Host -Prompt "Spécification de la direction du traffic (Outbound/Inbound)"
                $protocol = Read-Host -Prompt "Spécifiez le protocole de la règle de pare-feu (TCP, UDP, ICMPv4, ICMPv6)"
                $local_port = Read-Host -Prompt "Spécifiez le port cible"
                $action = Read-Host -Prompt "Action à faire (Allow/Block)"
                Invoke-Command -ComputerName $choixA08 -ArgumentList $nom_regle, $direction, $protocol, $local_port, $action -ScriptBlock { 
                    param($nom_regle, $direction, $protocol, $local_port, $action)
                    New-NetFirewallRule -DisplayName $nom_regle -Direction $direction -Protocol $protocol -LocalPort $local_port -Action $action
                } 
            }
            "9" {
                WriteLog "Vous avez selectionné l'action : Activation du pare-feu"
                $choixAO9 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?" 
                invoke-command -computername $choixAO9 -ScriptBlock {
                    Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled True }
                Write-Host "action reussie"
            }
            "10" {
                WriteLog "Vous avez selectionné l'action : Désactivation du pare-feu"
                $choixAO10 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?" 
                invoke-command -computername $choixAO10 -ScriptBlock {
                    Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False }
                Write-Host "action reussie"
            }
        
            "11" {
                WriteLog "Vous avez selectionné l'action : Installation de logiciel"
                $choixAO11 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
                $software = Read-Host "Quel logiciel voulez-vous installer ?"
                try {
                    Invoke-Command -ComputerName $choixAO11 -ScriptBlock {
                        param ($softwareToInstall)
                        choco install -y $softwareToInstall
                    } -ArgumentList $software -Credential (Get-Credential)
    
                    Write-Host "Le logiciel $software a été installé avec succès sur la machine $choixAO11."
                }
                catch {
                    Write-Host "Une erreur est survenue lors de l'installation : $_"
                }
            }
        
            "12" {
                WriteLog "Vous avez selectionné l'action : Déinstallation de logiciel"
                $choixAO12 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
                $softwareuni = Read-Host "Quel logiciel voulez-vous désinstaller ?"
                try {
                    Invoke-Command -ComputerName $choixAO12 -argumentlist $softwareuni -ScriptBlock {
                        param($softwareuni)
                        choco uninstall -y --force $softwareuni
                    } -Credential (Get-Credential)

                    Write-Host "Le logiciel $softwareuni a été désinstallé avec succès sur la machine $choixAO12."
                }
                catch {
                    Write-Host "Une erreur est survenue lors de la désinstallation : $_"
                }
            }
        
            "13" {
                WriteLog "Vous avez selectionné l'action : Exécution de script sur la machine distante"
                $choixAO13 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
                $chemin = Read-Host "ou est votre script ?"
                Invoke-Command -ComputerName $choixAO13 -ScriptBlock { & $args[0] } -ArgumentList $chemin
            }

            "R" {
                WriteLog "Option non disponible, retour vers : MenuPrincipal " 
                MenuPrincipal 
            }
            "Q" {
                WriteLog "Vous avez quitté le script  "
                exit
                Write-Host "Au revoir"
                exit 
            }
            default {
                WriteLog "Option non disponible "
                Write-Host "Option non disponible"        
                Start-Sleep -Seconds 2
                break 
            }
        }
    }
    catch {
        Write-Output "ATTENTION : Une erreur a été capturée : $($_.Exception.Message)"
    }
}
# Menu Action a Distance
function actions_utilisateur {
    try {
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
        $choixAU = Read-Host -Prompt "Quelle est l'action que vous souhaitez faire ?"
        Switch ($choixAU) {
            "1" {
                WriteLog "Vous avez selectionné l'action : Création de compte"
                # Création de compte
                $name_user = Read-Host "Quel utilisateur souhaitez-vous créer ?" 
                $choixAU1 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU1 -ArgumentList $name_user -ScriptBlock {
                    param($name_user)
                    $condition = Get-localuser -Name "$name_user" -ErrorAction SilentlyContinue
                    if (-not $condition) {
                        $Password = Read-Host "Choissisez un mot de passe" -AsSecureString
                        $params = @{
                            Name     = $name_user
                            Password = $Password
                        }
                        New-LocalUser @params -Confirm
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : L'utilisateur existe déjà"
                    }
                }
            }
            "2" {
                WriteLog "Vous avez selectionné l'action : Changement de mot de passe"
                # Changement de mot de passe
                $User_name = Read-Host " Saisissez le compte utilisateur à modifier :"
                $Password = Read-Host " Saisissez le nouveau mot de passe " -AsSecureString
                $choixAU2 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU2 -ArgumentList $User_name, $Password -ScriptBlock {
                    param($User_name, [SecureString] $Password)
                    $condition = Get-localuser -Name "$user_name" 
                    if ($condition) {
                        Set-LocalUser -Password $Password # peut etre -name $user_name
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : L'utilisateur n'existe pas"
                    }
                }
            }
            "3" {
                WriteLog "Vous avez selectionné l'action : Suppression de compte"
                # Suppression de compte
                $User_name = Read-Host " Saissisez le compte utilisateur à supprimer :" 
                $choixAU3 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU3 -argumentList $user_name -ScriptBlock {
                    param($user_name)
                    $condition = Get-localuser -Name "$user_name" 
                    if ($condition) {
                    
                        Remove-LocalUser -Name "$User_name" -Confirm 
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : L'utilisateur n'existe pas"
                    }
                }
            }
            "4" {
                WriteLog "Vous avez selectionné l'action : Désactivation de compte"
                # Désactivation de compte
                $User_name = Read-Host " Saissisez le compte utilisateur à désactiver :"
                $choixAU4 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU4 -Argumentlist $user_name -ScriptBlock {
                    param($user_name)
                    $condition = Get-localuser -Name "$user_name" 
                    if ($condition) {
                        Disable-LocalUser -Name $User_name -Confirm
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : L'utilisateur n'existe pas"
                    }
                }
            } 
            "5" {
                WriteLog "Vous avez selectionné l'action : Ajout à un groupe d'administration"
                # Ajout à un groupe d'administration
                $User_name = Read-Host " Saissisez le compte utilisateur à ajouter au groupe administrateur :"
                $group_name = Read-Host " Saissisez le groupe administrateur cible :"
                $choixAU5 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU5 -argumentlist $user_name, $group_name -ScriptBlock {
                    param($user_name, $group_name)
                    $condition = Get-localuser -Name $user_name 
                    $condition_2 = Get-localgroup -Name $group_name 
                    if ($condition -and $condition_2) {
                        Add-LocalGroupMember -Group "$group_name" -member $User_name -confirm
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : L'utilisateur ou le groupe cible n'existe pas"
                    }
                }
            }
            "6" {
                WriteLog "Vous avez selectionné l'action : Ajout à un groupe local"
                # Ajout à un groupe local
                $User_name = Read-Host " Saissisez le compte utilisateur à ajouter au groupe local :"
                $group_name = Read-Host " Saissisez le groupe local cible :"
                $choixAU6 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU6 -argumentlist $user_name, $group_name -ScriptBlock {
                    param($user_name, $group_name)
                    $condition = Get-localuser -Name $user_name 
                    $condition_2 = Get-localgroup -Name $group_name 
                    if ($condition -and $condition_2) {
                        Add-LocalGroupMember -Group $group_name -member $User_name -confirm
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : L'utilisateur ou le groupe cible n'existe pas"
                    }
                }
            }
            "7" {
                WriteLog "Vous avez selectionné l'action : Sortie d'un groupe local"
                # Sortie d’un groupe local
                $User_name = Read-Host " Saissisez le compte utilisateur à retirer au groupe local :"
                $group_name = Read-Host " Saissisez le groupe local cible :"
                $choixAU5 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixAU5 -ArgumentList $User_name, $group_name -ScriptBlock {
                    param($user_name, $group_name)
                    $condition = Get-localuser -Name $user_name 
                    $condition_2 = Get-localgroup -Name $group_name 
                    if ($condition -and $condition_2) { 
                        Remove-LocalGroupMember -Group $group_name -member $user_name -confirm
                        Write-host "Action réussie"
                    }
                    else {
                        Write-host "Erreur : L'utilisateur ou le groupe cible n'existe pas"
                    }
                }
            }       
            "R" {
                WriteLog "Vous avez selectionné : MenuPrincipal " 
                MenuPrincipal 
            }

            "Q" {
                WriteLog "Vous avez quitté le script "
                Write-Host "Au revoir"
                exit 
            }
            default {
                WriteLog "Option non disponible, retour vers : MenuPrincipal "
                Write-Host "Option non disponible"        
                Start-Sleep -Seconds 2
                break 
            } 
        }
    }
    catch {
        XX
    }
}

# Menu Information
function informations_ordinateur {
    try {
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
        |        installées                                   |
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
            "1" {
                WriteLog "Vous avez selectionné l'information : Version de l'OS"
                # Version de l'OS
                $choixIO1 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO1 -ScriptBlock {
                    Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version, ServicePackMajorVersion, OSArchitecture, CSName, WindowsDirectory, NumberOfUsers, BootDevice | Out-String |
                    Write-Host
                }
            }
            "2" {
                WriteLog "Vous avez selectionné l'information : Nombre d'interface"
                # Version de l'OS
                $choixIO2 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO2 -ScriptBlock {
                    Get-NetAdapter | Format-List Name, InterfaceIndex, MacAddress, MediaConnectionState, LinkSpeed | Out-String |
                    Write-host
                }
            }
            "3" {
                WriteLog "Vous avez selectionné l'information : Adresse IP des interfaces"
                # Adresse IP de chaque interface
                $choixIO3 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO3 -ScriptBlock {
                    Get-NetIPConfiguration | Out-String | write-host
                }
            }
            "4" {
                WriteLog "Vous avez selectionné l'information : Adresse MAC"
                # Adresse Mac
                $choixIO4 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO4 -ScriptBlock {
                    Get-NetAdapter | Select-Object Index, Name, MacAddress | Out-String | write-host
                }
            }
            "5" {
                WriteLog "Vous avez selectionné l'information : Liste des applications/paquets installés"
                # Liste des applications installées
                ########## A formatter
                $choixIO5 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO5 -ScriptBlock {
                    Get-itemproperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -ne $null } | Select-Object DisplayName, DisplayVersion, InstallDate | out-string | write-host 
            
                }
            } 
            "6" {
                WriteLog "Vous avez selectionné l'information : Liste des utilisateurs locaux "
                # Liste des utilisateurs locaux           
                $choixIO6 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO6 -ScriptBlock {
                    Get-LocalUser | Out-String | write-host
                }
            }
            "7" {
                WriteLog "Vous avez selectionné l'information : Type de CPU, nombre de coeurs"
                # Type de CPU, nombre de coeurs
                $choixIO7 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO7 -ScriptBlock {
                    Get-WmiObject Win32_Processor | Out-String | write-host
                }
            }
            "8" {
                WriteLog "Vous avez selectionné l'information : Mémoire RAM totale"
                # Mémoire RAM totale
                ############# pas d'affichage 
                $choixIO8 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                $inforam = Invoke-Command -ComputerName $choixIO8 -ScriptBlock {
            (GEt-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1MB }
                Write-host "$inforam MB"
            }
            "9" {
                WriteLog "Vous avez selectionné l'information : Utilisation de la RAM"
                # Utilisation de la RAM        
                $choixIO9 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO9 -ScriptBlock {
                    $totalMemory = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory 
                    $totalMemoryMB = [math]::round($totalMemory / 1Mb )
                    Write-Host $totalMemoryMB 
                }
            }
            "10" {
                WriteLog "Vous avez selectionné l'information : Utilisation du disque"
                # Utilisation du disque        
                $choixIO10 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO10 -ScriptBlock {
                    Get-PSDrive -name C | Sort-Object C | out-string | write-host 
                
                }
            }
            "11" {
                WriteLog "Vous avez selectionné l'information : Utilisation du processeur"
                # Utilisation du processeur    
                $choixIO11 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO11 -ScriptBlock {
                    Get-CimInstance win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object Average | Out-String | write-host
                }
            }
            "12" {
                WriteLog "Vous avez selectionné l'information : Liste des ports ouverts"
                # Liste des ports ouverts      
                $choixIO12 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO12 -ScriptBlock {
                    Get-NetTCPConnection -State Listen | Select-Object LocalPort, State | Sort-Object -Property LocalPort | out-string | write-host 
                }
            }
            "13" {
                WriteLog "Vous avez selectionné l'information : Statut du pare-feu"
                # Statut du pare-feu
                $choixIO13 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
                Invoke-Command -ComputerName $choixIO13 -ScriptBlock {
                    Get-NetFirewallProfile | Select-Object Name, Enabled | Out-String | write-host }
            }
            "R" {
                WriteLog "Vous avez selectionné : Menu principal"
                MenuPrincipal 
            }
            "Q" {
                WriteLog "Vous êtes sorti du script"
                Write-Host "Au revoir" 
                exit 
            }
            default {
                WriteLog "Option non disponible"
                Write-Host "Option non disponible"
                Start-Sleep -Seconds 2 
            }
        }
    }
    catch {
        Write-Output "ATTENTION : Une erreur a été capturée : $($_.Exception.Message)"
    }
}
# Menu Information a distance
function informations_utilisateur {
    try {
        Write-Host @"
        +=======================================================================================+
        |  Informations sur Utilisateur                                                         |
        +=======================================================================================+
        |                                                                                       |
        |    1)  Date de dernière connexion d’un utilisateur                                    |
        |    2)  Date de dernière modification du mot de passe                                  |
        |    3)  Liste des sessions ouvertes par l'utilisateur                                  |
        |    4)  Droits/permissions de l’utilisateur sur un dossier (ne fonctionne pas à 100%)  |
        |    5)  Droits/permissions de l’utilisateur sur un fichier (ne fonctionne pas à 100%)  |
        |    R)  Retour au Menu Principal                                                       |
        |    Q)  Quitter                                                                        |
        |                                                                                       |
        +=======================================================================================+                            
        
"@

        $choixIU = Read-Host -Prompt "Quelle est l'Information que vous souhaitez ?"
        Switch ($choixIU) {
            "1" {
                WriteLog "Vous avez selectionné l'information : Date de dernière connexion d'un utilisateur"
                $choixIU01 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
                Invoke-Command -ComputerName $choixIU01 -ScriptBlock {
                
                    $logPath = "Microsoft-Windows-User Profile Service/Operational"
                    # Define the event IDs to filter by (2 for Logon, 4 for Logoff)
                    $logonEventID = 2
                    # Retrieve logon and logoff events from the User Profile Service Operational log
                    $events = Get-WinEvent -LogName $logPath | Where-Object { $_.Id -eq $logonEventID }
                    #-or $_.Id -eq $logoffEventID }
                    $eventTable = $events | ForEach-Object {
                        [PSCustomobject]@{
                            "Timestamp"   = $_.timecreated
                            "ID"          = $_.Id
                            "MessageType" = $_.leveldisplayname
                            "Message"     = $_.message
                        }
                    }
                    $resultat = $eventtable | Select-Object -first 1 "Timestamp", "ID", "Message" | Out-String | Write-Output
                    Write-Host "$resultat"
                }
            }
            "2" {
                WriteLog "Vous avez selectionné l'information : Date de dernière modification du mot de passe"
                $choixIU02 = Read-Host "Quel est l'ordinateur cible ?"
                Invoke-Command -ComputerName $choixIU02 -ScriptBlock {
                    $resultat = Get-WinEvent -LogName "Security" | Where-Object { $_.ID -eq 4723 -or $_.ID -eq 4724 } | Select-Object -first 1 -Property Id, TimeCreated
                    Write-Host $resultat
                }   
            }
            "3" {
                WriteLog "Vous avez selectionné l'information : Liste des sessions ouvertes par l'utilisateur"
                $choixIU03 = Read-Host "Quel est l'ordinateur cible ?" 
                Invoke-Command -ComputerName $choixIU03 -ScriptBlock { $user = quser
                    $actif = $user | Where-Object { $_ -match "Actif" }
                    Write-Host $actif
                }
            }
            "4" {
                WriteLog "Vous avez selectionné l'information : Droits/permissions de l’utilisateur sur un dossier"
                $choixIU04 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
                $choixdos = Read-Host -Prompt "Quel est le dossier cible ?"
                $choixuser = Read-Host -Prompt "Quel est l'utilisateur cible ?"
                Invoke-Command -ComputerName $choixIU04 -argumentList $choixdos, $choixuser -ScriptBlock { 
                    param($choixdos, $choixuser)        
                (get-acl $choixdos).access | Where-object { $_.identityReference -like "*$choixuser*" } | Select-Object IdentityReference, FileSystemRights |
                    Out-String | Write-Host 
                }  
            
            }
            "5" {
                WriteLog "Vous avez selectionné l'information : Droits/permissions de l’utilisateur sur un fichier"
                $choixIU05 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
                $choixdos = Read-Host -Prompt "Quel est le fichier cible ?"
                $choixuser = Read-Host -Prompt "Quel est l'utilisateur cible ?"
                Invoke-Command -ComputerName $choixIU05 -argumentList $choixdos, $choixuser -ScriptBlock { 
                    param($choixdos, $choixuser)        
                (get-acl $choixdos).access | Where-object { $_.identityReference -like "*$choixuser*" } | Select-Object IdentityReference, FileSystemRights |
                    Out-String | Write-Host
                }
            }
            "R" {
                WriteLog "Vous avez selectionné : Menu Principal" 
                MenuPrincipal 
            }
            "Q" {
                WriteLog "Vous êtes sorti du script" 
                Write-Host "Au revoir" 
                exit 
            }
            default {
                WriteLog "Option non disponible"
                Write-Host "Option non disponible"
                Start-Sleep -Seconds 2 
            }
        }
    } 
    catch {
        <#Do this if a terminating exception happens#>
        Write-Output "ATTENTION : Une erreur a été capturée : $($_.Exception.Message)"
    }
}

try {
    # Appel initial du menu principal
    do {
        $choiceMP = MenuPrincipal
    } while ( $choiceMP -ne "Q"
        <# Condition that stops the loop if it returns false #>
    )
}
catch { 
    Write-Output "ATTENTION : Une erreur a été capturée : $($_.Exception.Message)"
}
finally {
    $Logfile = "C:\Windows\System32\LogFiles\"
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $User = $env:USERNAME
    Add-Content -Path "$Logfile\log_evt.log" -Value "$stamp - $user-********ENDScript********"
}

