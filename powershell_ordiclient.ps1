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
        |    4)  Mise à jour Système  ok ~~                   |
        |    5)  Création de répertoire                       |
        |    6)  Suppression de répertoire                   |
        |    7)  Prise de main à distance                  |
        |    8)  Définition de règles de pare-feu          |
        |    9)  Activation du pare-feu                       |
        |    10) Désactivation du pare-feu                   |
        |    11) Installation de logiciel                    |
        |    12) Désinstallation de logiciel                  |
        |    13) Exécution de script sur la machine distante   |
        |    R)  Retour au Menu Principal                     |
        |    Q)  Quitter                                      |
        |                                                     |
        +=====================================================+

"@

    $choixAO = Read-Host -Prompt "Quelle est l'action que vous souhaitez faire ?"
    Switch ($choixAO) {
        "1" {
            $choixAO1 = Read-Host -Prompt "Quel est le nom de l'ordinateur a arreter"
            Stop-Computer -ComputerName $choixAO1 -Force -Credential (get-Credential)
        } 
        "2" {
            $choixAO2 = Read-Host -Prompt "Quel est l'ordinateur a redemarrer" 
            Restart-Computer -ComputerName $choixAO2 -Force -Credential (get-Credential)
        }
        "3" {
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
            Write-Host "Lancement de connexion à distance" 
            Start-Process "mstsc"
        }
        
        "8" {
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
            $choixAO9 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?" 
            invoke-command -computername $choixAO9 -ScriptBlock {
                Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled True }
        }
        "10" {
            $choixAO10 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?" 
            invoke-command -computername $choixAO10 -ScriptBlock {
                Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False }
        }
        
        "11" {
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
            $choixAO13 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
            $chemin = Read-Host "ou est votre script ?"
            Invoke-Command -ComputerName $choixAO13 -ScriptBlock { & $args[0] } -ArgumentList $chemin
        }

        "R" { MenuPrincipal }
        "Q" {
            exit
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
        |    1)  Création de compte ok                         |
        |    2)  Changement de mot de passe  ok                |
        |    3)  Suppression de compte   ok                    |
        |    4)  Désactivation de compte   ok                   |
        |    5)  Ajout à un groupe d'administration   ok        |
        |    6)  Ajout à un groupe local   ok                   |
        |    7)  Sortie d’un groupe local    ok                 |
        |    R)  Retour au Menu Principal      ok               |
        |    Q)  Quitter                                      |
        |                                                     |
        +=====================================================+

"@
    $choixAU = Read-Host -Prompt "Quelle est l'action que vous souhaitez faire ?"
    Switch ($choixAU) {
        "1" {
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
            # Changement de mot de passe
            $User_name = Read-Host " Saisissez le compte utilisateur à modifier :"
            $Password = Read-Host " Saisissez le nouveau mot de passe " -AsSecureString
            $choixAU2 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixAU2 -ArgumentList $User_name, $Password -ScriptBlock {
                param($User_name, $Password)
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
        "R" { MenuPrincipal }

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
        |    1)  Version de l'OS                            |
        |    2)  Nombre d'interface                         |
        |    3)  Adresse IP de chaque interface             |
        |    4)  Adresse Mac                                 |
        |    5)  Liste des applications/paquets               |
        |        installées                                |
        |    6)  Liste des utilisateurs locaux               |
        |    7)  Type de CPU, nombre de coeurs, etc.         |
        |    8)  Mémoire RAM totale                         |
        |    9)  Utilisation de la RAM                       |
        |    10) Utilisation du disque                      |
        |    11) Utilisation du processeur                |
        |    12) Liste des ports ouverts                    |
        |    13) Statut du pare-feu                          |
        |    R)  Retour au Menu Principal                     |
        |    Q)  Quitter                                      |
        |                                                     |
        +=====================================================+
    
"@

    $choixIO = Read-Host -Prompt "Quelle est l'Information que vous souhaitez ?"
    Switch ($choixIO) {
        "1" {
            # Version de l'OS
            $choixIO1 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO1 -ScriptBlock {
                Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version, ServicePackMajorVersion, OSArchitecture, CSName, WindowsDirectory, NumberOfUsers, BootDevice | Out-String |
                write-host 
            }
        }
        "2" {
            # Version de l'OS
            $choixIO2 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO2 -ScriptBlock {
                Get-NetAdapter | Format-List Name, InterfaceIndex, MacAddress, MediaConnectionState, LinkSpeed | Out-String |
                Write-host 
            }
        }
        "3" {
            # Adresse IP de chaque interface
            $choixIO3 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO3 -ScriptBlock {
                Get-NetIPConfiguration | Out-String | write-host
            }
        }
        "4" {
            # Adresse Mac
            $choixIO4 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO4 -ScriptBlock {
                Get-NetAdapter | Select-Object Index, Name, MacAddress | Out-String | write-host
            }
        }
        "5" {
            # Liste des applications installées
            $choixIO5 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO5 -ScriptBlock {
                Get-itemproperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -ne $null } | Select-Object DisplayName, DisplayVersion, InstallDate
            }
        } 
        "6" {
            # Liste des utilisateurs locaux           
            $choixIO6 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO6 -ScriptBlock {
                Get-LocalUser | Out-String | write-host
            }
        }
        "7" {
            # Type de CPU, nombre de coeurs
            $choixIO7 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO7 -ScriptBlock {
                Get-WmiObject Win32_Processor | Out-String | write-host
            }
        }
        "8" {
            # Mémoire RAM totale           
            $choixIO8 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO8 -ScriptBlock {
                Get-CimInstance win32_physicalmemory | Format-Table Manufacturer, Banklabel, Configuredclockspeed, Devicelocator, Capacity, Serialnumber -autosize | Out-String | write-host
            }
        }
        "9" {
            # Utilisation de la RAM        
            $choixIO9 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO9 -ScriptBlock {
                $totalMemory = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory 
                $totalMemoryMB = [math]::round($totalMemory / 1Mb )
                Write-Host $totalMemoryMB 
            }
        }
        "10" {
            # Utilisation du disque        
            $choixIO10 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO10 -ScriptBlock {
                $disk = Get-PSDrive 
                Write-Host $disk
            }
        }
        "11" {
            # Utilisation du processeur    
            $choixIO11 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO11 -ScriptBlock {
                Get-CimInstance win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object Average | Out-String | write-host
            }
        }
        "12" {
            # Liste des ports ouverts      
            $choixIO12 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO12 -ScriptBlock {
                Get-NetTCPConnection -State Listen | Select-Object LocalPort, State | Sort-Object -Property LocalPort | Format-Table -AutoSize
            }
        }
        "13" {
            # Statut du pare-feu
            $choixIO13 = Read-Host "Quel est l'adresse IP de la machine cible ?" 
            Invoke-Command -ComputerName $choixIO13 -ScriptBlock {
                Get-NetFirewallProfile | Select-Object Name, Enabled | Out-String | write-host }
        }
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
        |    1)  Date de dernière connexion d’un utilisateur   ok     |
        |    2)  Date de dernière modification du mot de passe  ok    |
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

                $eventtable | Select-Object -first 1 "Timestamp", "ID", "Message" 
            }
        }
        "2" {
            $choixIU02 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
            Invoke-Command -ComputerName $choixIU02 -ScriptBlock { Get-WinEvent -LogName "Security" | Where-Object { $_.ID -eq 4723 -or $_.ID -eq 4724 } | Select-Object -Property Id, TimeCreated
            }   
        }
        "3" { 
            $choixIU03 = Read-Host -Prompt "Quel est l'ordinateur cible ?" 
            Invoke-Command -ComputerName $choixIU03 -ScriptBlock { $user = quser
                $actif = $user | Where-Object { $_ -match "Actif" }
                $actif } 
        }
        "4" { 
            $choixIU04 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
            $choixdos = Read-Host -Prompt "Quel est le dossier cible ?"
            $choixuser = Read-Host -Prompt "Quel est l'utilisateur cible ?"
            Invoke-Command -ComputerName $choixIU04 -argumentList $choixdos, $choixuser -ScriptBlock { 
                param($choixdos, $choixuser)        
                (get-acl $choixdos).access | Where-object { $_.identityReference -like "*$choixuser*" } | Select-Object IdentityReference, FileSystemRights | Format-table -AutoSize
            }  
        }
        "5" { 
            $choixIU05 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
            $choixdos = Read-Host -Prompt "Quel est le fichier cible ?"
            $choixuser = Read-Host -Prompt "Quel est l'utilisateur cible ?"
            Invoke-Command -ComputerName $choixIU05 -argumentList $choixdos, $choixuser -ScriptBlock { 
                param($choixdos, $choixuser)        
                (get-acl $choixdos).access | Where-object { $_.identityReference -like "*$choixuser*" } | Select-Object IdentityReference, FileSystemRights | Format-table -AutoSize
            }
        }
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
    $connect = read-host "a quel ordinateur souhaitez-vous vous connecter ?" #CLIWIN01
    Enter-Pssession -ComputerName $connect -Credential (Get-Credential)
}
function deconnection {
    Exit-PSsession
}
# Appel initial du menu principal
do {
    $choiceMP = MenuPrincipal
} while ( $choiceMP -ne "Q"
    <# Condition that stops the loop if it returns false #>
)
