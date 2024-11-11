commandes ne marchent pas

Action ordinateur :
5 6 8 11 12 13

inform utilis erwan



rajouter les invoke commande dans les menus :
action ordin matt
inform utilis  erwan
action utilis matt

"11" {
    $choixAO11 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
    $software = Read-Host "Quel logiciel voulez-vous installer ?"

    # Utilisation de Invoke-Command avec les privilèges administratifs à distance
    Invoke-Command -ComputerName $choixAO11 -ScriptBlock {
        param ($softwareName)

        # Utilisation de Start-Process avec les privilèges administratifs
        Start-Process "choco" -ArgumentList "install", $softwareName, "-y", "--force" -Verb RunAs
    } -ArgumentList $software -Credential (Get-Credential)
}

"3" {
            $choixAO3 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
            $username = Read-Host -Prompt "Entrez le nom d'utilisateur à verrouiller"
    
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
    |    1)  Création de compte utilisateur local                                       |
    |    2)  Changement de mot de passe                                  |
    |    3)  Verrouillage                                 |
    |    4)  Suppression de compte utilisateur local                         |
    |    5)  Désactivation de compte utilisateur local                       |
    |    6)  Ajout à un groupe d'administration                   |
    |    7)  Ajout à un groupe local                     |
    |    8)  Sortie d’un groupe local            |
    |                                            |
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
    |    1)  Date de dernière connexion d’un utilisateur                              |
    |    2)  Date de dernière modification du mot de passe                           |
    |    3)  Liste des sessions ouvertes par l'utilisateur               |
    |    4)  Droits/permissions de l’utilisateur sur un dossier                                  |
    |    5)  Droits/permissions de l’utilisateur sur un fichier                     |
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

# Menu 2 Action
#A1 : Création de compte utilisateur local A VERIF

New-LocalUser


#A2 : changement de mdp

Set-LocalUser
        #Vérfie l'utilisateur existe (si vide alors on passe l'étape)
        #Mettre l'ancien mdp 
        #Mettre nouveau mdp
        #Confirmation nouveau mdp
        #Message erreur / changement réussi


#A3 suppression de compte utilsiateur local 

Remove-LocalUser

#A4 Désactivation compte utilisateur local

Disable-LocalUser
    #Verif utilisateur existe
        #SI non -> erreur
        #SI oui ->Confirmation 
            #commande désac
        #SI non -> erreur

#A5 ajout à un grp d'adminsitration 
Add-?????????GroupMember 
    #Verif utilisateur existe
    #Demande quel grp d'admin ?
        #Verif grp existe
            #Confirmation 
        #SI non -> erreur

#A6 ajout à un grp local
Add-LocalGroupMember 
    #Verif utilisateur existe
        #SI non -> erreur
    #Demande quel grp local ?
        #Verif grp existe
            #Confirmation 
        #SI non -> erreur

#A7  sortie d'un groupe local
Remove-LocalGroupMember
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


#Menu 2 Info

#I1 Date de derniere connexion d'un utilisateur 
﻿<#
.SYNOPSIS
	Obtenir la date et l'heure de dernière connexion d'un utilisateur ou de tous les utilisateurs activés, via lecture de l'attribut lastLogon sur tous les DC.

.EXAMPLE
    Get-ADUserLastLogon -Identity "admin.fb"
    Get-ADUserLastLogon
    
.INPUTS
.OUTPUTS
.NOTES
	NAME:	Get-ADUserLastLogon.ps1
	AUTHOR:	Florian Burnel
	EMAIL:	florian.burnel@it-connect.fr
	VERSION HISTORY:
        1.0   14/05/2024
        1.1   18/07/2024

#>

function Get-ADUserLastLogon {

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

}
    #I2   date de derniere modification du mot de passe

Get-LocalUser -Name "NomUtilisateur" | Select-Object Name, PasswordLastSet

    #I3  Liste des sessions ouvertes par l'utilisateur
    
Get-PSSession -ComputerName "localhost"

    #I4  Droits/permissions de l’utilisateur sur un dossier

Get-PublicFolderClientPermission -Identity "\My Public Folder" -User Chris | Format-List
    

    #I5  Droits/permissions de l’utilisateur sur un fichier
