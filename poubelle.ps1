Get-WinEvent -LogName "Security" | Where-Object { $_.ID -eq 4723 -or $_.ID -eq 4724 } | Select-Object -Property Id, TimeCreated

"11" {
            $choixAO11 = Read-Host -Prompt "Quel est l'adresse IP de la machine cible ?"
            $software = Read-Host "Quel logiciel voulez-vous installer ?"
            # Tentative d'installation du logiciel sur la machine cible
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




    clear host
# Define the Event Viewer log path for User Profile Service Operational
$choixIU01 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
Invoke-Command -ComputerName $choixIU01 -ScriptBlock {
$logPath = "Microsoft-Windows-User Profile Service/Operational"

# Define the event IDs to filter by (2 for Logon, 4 for Logoff)
$logonEventID = 2
$logoffEventID = 4

# Retrieve logon and logoff events from the User Profile Service Operational log
$events = Get-WinEvent -LogName $logPath | Where-Object { $_.Id -eq $logonEventID}
#-or $_.Id -eq $logoffEventID }
$eventTable= $events | ForEach-Object {
[PSCustomobject]@{
    "Timestamp" = $_.timecreated
    "ID" = $_.Id
    "MessageType" = $_.leveldisplayname
    "Message" = $_.message
    }
    }

$eventtable | Select-Object -first 1 "Timestamp", "ID", "Message" 
}

"2" {$choixIU02 = Read-Host -Prompt "Quel est l'ordinateur cible ?"
            Invoke-Command -ComputerName $choixIU02 -ScriptBlock {Get-WinEvent -LogName "Security" | Where-Object {$_.ID -eq 4723 -or $_.ID -eq 4724}
            }}
        "3" {$choixIU02 = Read-Host -Prompt "Quel est l'ordinateur cible ?" 
            Invoke-Command -ComputerName $choixIU03 -ScriptBlock {$user=quser
            $actif= $user | Where-Object{ $_ -match "Actif" }
            $actif }}
        "4" { $choixIU04 = Read-Host -Prompt "Quel est l'ordinateur cible ?"

            Invoke-Command -ComputerName $choixIU03 -ScriptBlock { 
            $choixdos = Read-Host -Prompt "Quel est le dossier cible ?"
            $choixuser = Read-Host -Prompt "Quel est l'utilisateur cible ?"
            (get-acl $choixdos).access | Where-object {$_.identityReference -like "*$choixuser*"} | Select-Object IdentityReference,FileSystemRights,AccessControlType,InheritanceFlags | Format-table -AutoSize
        } }



        # Log 
function start_log{
    New-Item -Path "C:\Windows\System32\LogFiles\" -ItemType File -Name "log_evt.log"
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $User=$env:USERNAME
    $Logfile = "C:\Windows\System32\LogFiles\log_evt.log"
    Add-Content $Logfile -Value "$stamp - $user-********StartScript********"
}
$Logfile = "C:\Windows\System32\LogFiles\log_evt.log"
start_log
function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$User=$env:Username
$LogMessage = "$Stamp - $User - $LogString"
Add-content $LogFile -value $LogMessage
}
# log info 
function log_info {
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $User=$env:Username
    $log_info_file="C:\Users\$env:USERNAME\Documents"
    if (!(Test-path -Path $log_info_file)) {
        New-Item -Path "C:\Users\$env:USERNAME\Documents\" -ItemType File -Name "info_$user_$stamp.txt"
    }
    $LogMessage = "$LogString `n ------------------------------------"
    Add-content $LogFile -value $LogMessage
}

# condition d'arguments pour enregistrement
$choixIO = Read-Host -Prompt "Quelle est l'Information que vous souhaitez ?"
    $arguments=$choixIO -split '[ ,]+'| Where-Object { $_ -match '^\d+$'}
    $arg_count=$arguments.Count
    if( $arg_count -le 1){}
        foreach ($arg in $arguments){} 
        switch ($x) {
            condition {  }
            Default {}
        }
    else{}


