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
