# Documentation Administrateur

 1. [Prérequis technique](#1-prérequis-technique)
 2. [Etapes d'installation](#2-etapes-dinstallation)
    1. Installations pour debian 12
    2. Installations pour windows Serveur
    3. Installations pour Windows 10 pro 
 4. [configuration](#3-configuration)
 5. [FAQ](#4-faq)
     

# 1. Prérequis Technique
  * 1 Serveur Windows nommé SRVWIN01
    * en windows serveur 2022 avec les dernieres mise a jour et les firewall desactivé 
  * 1 Client Windows nommé CLIWIN01
    * en Windows 10 avec les dernieres mise a jour et les firewall desactivé
  * 1 Serveur Dedian nommé SRVLX01
    * en Dedian 12 avec les dernieres mise a jour et les firewall desactivé
  * 1 en Ubuntu nommé CLILIN01
    * en Ubunto 24.04 LTS avec les dernieres mise a jour et les firewall desactivé
   
# 2. Etapes d'installation
   1.  Installations pour debian 12
1. **Installer sudo et ssh-service sur le client et le serveur :**

    - **Installer sudo :**
    ```bash
    sudo apt update
    sudo apt install sudo -y
    ```

    - **Installer OpenSSH server (ssh) :**
    ```bash
    sudo apt install openssh-server -y
    ```

2. **Installer Git sur le serveur :**
    ```bash
    sudo apt install git -y
    ```
3. **Installer PSWindowsUpdate sur le client**
   ```powershell
   Install-Module -Name PSWindowsUpdate -Force
   ```
4. **Installer chocolatey sur le client et peutetre sur le serveur**
   ```bash
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```
1. **Cloner le dépôt sur le serveur dans le dossier de votre choix :**
    ```bash
    git clone git@github.com:WildCodeSchool/TSSR-2409-JAUNE-P2-G2-TheScriptingProject.git
    ```
    2. Installation pour Windows serveur

   * . Installation de WinRM
    ```powershell
    Start-Service -Name WinRM
    #Exécutez la commande suivante pour configurer WinRM pour les accès à distance
    Enable-PSRemoting -Force
    #Configurez les règles du pare-feu pour autoriser le trafic WinRM
    New-NetFirewallRule -Name "WinRM-HTTP" -DisplayName "Windows Remote
    Management (HTTP-In)" -Enabled True -Direction Inbound -Protocol TCP -
    LocalPort 5985
    #Ajouter le PC client à la liste des hôte de confiance avec la commande
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.16.20.20" -Force
    ```
    * . Intallation de Powersehll 7
      ```powershell
      iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
      ```
    3. Installation pour Windows client
       ```powershell
       # Exécutez la commande suivante pour démarrer le service WinRM
       Set-Service -Name winrm -StartupType Automatic
       # Pour démarrer le service immédiatement, utilise
       Start-Service -Name WinRM
       #Configurez les paramètres de l'hôte distant pour permettre la connexion à distance :
       Set-Item WSMan:\localhost\Client\TrustedHosts -Value 172.16.20.05 -Force
       ```

       Ouvrir une console PowerShell en administrateur
       ```powershell
       # Récupérer l'index de l'interface
       $Index = (Get-NetConnectionProfile).InterfaceIndex
       # Modifier le profil en catégorie Privée
       Set-NetConnectionProfile -InterfaceIndex $Index -NetworkCategory Private
       # Si le pare-feu est activé mettre l'exception WinRM
       Enable-PSRemoting -Force
       Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -Enabled True
       # OU
       Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"
       ```

       ```cmd.exe
       # Configuration du LocalAccountTokenFilterPolicy
       reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v
       LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
       # Configuration du WinRM
       winrm quickconfig
       ```

       ```powershell
       Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
       #Configuration sur les Clients du démarrage automatique du service Registre Distant via la commande PowerShell
       # Définir le démarrage automatique du service "Registre Distant"
       Set-Service -Name RemoteRegistry -StartupType Automatic
       # Démarrer le service "Registre Distant"
       Start-Service -Name RemoteRegistry
       # Création d'un nouveau compte utilisateur
       New-LocalUser -Name "Administrator" -Description "Compte local identique
       au compte du domaine" -Password (ConvertTo-SecureString "Azerty1*" -
       AsPlainText -Force) -FullName "Administrator" -PasswordNeverExpires -
       UserMayNotChangePassword
       # Ajout du compte au groupe des administrateurs locaux
       Add-LocalGroupMember -Group "Administrateurs" -Member "Administrator"
       ```
       
       * . Modules additionnels
       ```powershell
       #Il faut dans un premier temps installer sur chaque Client PSWindowsUpdate via la commande :
       Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
       Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.0.3 -Force -Confirm:$false
       #Puis vous devez retirer la restriction des scripts via la commande :
       Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
       ```



       

# 3. configuration


# 4. FAQ








