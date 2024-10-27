#menu d'options 1 
    # Action
        # Sur cet ordi
        # Remote
    # Information 
        #Sur cet ordi
        # Remote

 
Switch ("<valeur à tester>")
{
    "<condition 1>" { "bloc de code (instructions)" }
    "<condition 2>" { "bloc de code (instructions)" }
    "<condition 3>" { "bloc de code (instructions)" }
    "<condition 4>" { "bloc de code (instructions)" }
    Default { "bloc de code (instructions)" }

    $action = Read-Host -Prompt "Que souhaiter vous faire ?"
    $information = Read-Host -Prompt "Que souhaiter vous faire ?"

switch ($action)
{
    "notepad" { Start-Process notepad.exe }
    "powershell" { Start-Process powershell.exe }
    "calc" { Start-Process calc.exe }
    "regedit" { Start-Process regedit.exe }
    Default { "Désolé, je n'ai pas trouvé ce logiciel" }
}
}
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
