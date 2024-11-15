# Documentation Administrateur

## Table des matières
1. [Prérequis Techniques](#1-prérequis-techniques)
   - [Prérequis pour Debian 12](#prérequis-pour-debian-12)
   - [Prérequis pour Ubuntu 24](#prérequis-pour-ubuntu-24)
   - [Prérequis pour Windows server 22](#prérequis-pour-windows-server-22)
   - [Prérequis pour Windows 10](#prérequis-pour-windows-10-pro)
3. [Étapes d'Installation](#2-étapes-dinstallation)
4. [Configuration](#3-configuration)
5. [FAQ](#4-faq)

---

## 1. Prérequis Techniques

### Prérequis pour Debian 12

1. **Installer openssh-server, git et ufw :**

   ```bash
   sudo apt update
   sudo apt install -y openssh-server git ufw
   ```
2. **Configurer SSH :**
   - **Editer le fichier /etc/ssh/sshd_config**
     ```bash
     nano /etc/ssh/sshd_config
     ```
   - **Décommenter les lignes suivantes :**
     ```
     X11Forwarding yes
     X11DisplayOffset 10
     ```
   - **Activer et lancer le service ssh :**
     ```
     systemctl enable ssh.service
     systemctl start ssh.service
     ```
     
   - **Activer et lancer le service ssh :**
     ```bash
     systemctl enable ssh.service
     systemctl start ssh.service
     systemctl restart networking
     ```

### Prérequis pour Ubuntu 24

1. **Installer openssh-server :**
   
```bash
   sudo apt update
   sudo apt install -y openssh-server
   ```

2. **Configurer SSH :**
   - **Editer le fichier /etc/ssh/sshd_config**
     ```bash
     nano /etc/ssh/sshd_config
     ```
     
   - **Décommenter les lignes suivantes :**
     ```
     PermitRootLogin yes
     X11Forwarding yes
     X11DisplayOffset 10
     ```
     
   - **Activer et lancer le service ssh :**
     ```bash
     systemctl enable ssh.service
     systemctl start ssh.service
     systemctl restart networking
     ```
     
---

### Prérequis pour Windows Server 22

1. **Configurer WinRM (Windows Remote Management) :**

   ```powershell
   Start-Service -Name WinRM
   Enable-PSRemoting -Force
   New-NetFirewallRule -Name "WinRM-HTTP" -DisplayName "Windows Remote Management (HTTP-In)" -Enabled True -Direction Inbound -Protocol TCP -LocalPort 5985
   Set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.16.20.20" -Force
   ```

2. **Installer PowerShell 7 :**

   ```powershell
   iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
   ```

### Prérequis pour Windows 10 Pro

1. **Configurer WinRM :**

   ```powershell
   Set-Service -Name winrm -StartupType Automatic
   Start-Service -Name WinRM
   Set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.16.20.05" -Force
   Enable-PSRemoting -Force
   ```

2. **Configurer le profil réseau en privé :**

   ```powershell
   $Index = (Get-NetConnectionProfile).InterfaceIndex
   Set-NetConnectionProfile -InterfaceIndex $Index -NetworkCategory Private
   Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"
   ```

3. **Configurer le registre et les services :**

   ```cmd
   reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
   winrm quickconfig
   ```

4. **Configurer le service Registre Distant :**

   ```powershell
   Set-Service -Name RemoteRegistry -StartupType Automatic
   Start-Service -Name RemoteRegistry
   ```

5. **Créer un utilisateur administrateur local :**

   ```powershell
   New-LocalUser -Name "Administrator" -Description "Compte local identique au compte du domaine" -Password (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) -FullName "Administrator" -PasswordNeverExpires -UserMayNotChangePassword
   Add-LocalGroupMember -Group "Administrateurs" -Member "Administrator"
   ```

6. **Installer des modules additionnels :**

   ```powershell
   Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
   Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.0.3 -Force -Confirm:$false
   Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
   ```

---

## 2. Étapes d'Installation

### Pour Linux

- Importer sur le serveur les fichier `serveur.sh` et `client.sh` dans le dossier de votre choix à partir du dépot :
  [Cliquez ici](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P2-G2-TheScriptingProject/tree/main)
  
### Pour Windows

    - Importer sur le serveur le fichier `script.ps1` dans le dossier de votre choix à partir du dépot :
  [Cliquez ici](https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P2-G2-TheScriptingProject/tree/main)

---

## 3. Configuration

- **Serveur Windows** nommé `SRVWIN01`
  - Windows Server 2022 avec les dernières mises à jour appliquées et le pare-feu désactivé
  - Configurer l'adresse IP en `172.16.20.5/24`
- **Client Windows** nommé `CLIWIN01`
  - Windows 10 avec les dernières mises à jour appliquées et le pare-feu désactivé
  - Configurer l'adresse IP en `172.16.20.20/24`
- **Serveur Debian** nommé `SRVLX01`
  - Debian 12 avec les dernières mises à jour appliquées et le pare-feu désactivé
  - Configurer l'adresse IP en `172.16.20.10/24`
- **Client Ubuntu** nommé `CLILIN01`
  - Ubuntu 24.04 LTS avec les dernières mises à jour appliquées et le pare-feu désactivé
  - Configurer l'adresse IP en `172.16.20.30/24`

## 4. FAQ

### 1. **Pourquoi ne puis-je pas me connecter via SSH sur mon serveur Debian ou Ubuntu ?**
- **Solution :** Vérifiez que le service SSH est bien activé et en cours d'exécution :
  ```bash
  sudo systemctl status ssh.service
  ```
  Si nécessaire, activez-le et démarrez-le :
  ```bash
  sudo systemctl enable ssh.service
  sudo systemctl start ssh.service
  ```
  Assurez-vous également que le pare-feu autorise les connexions SSH :
  ```bash
  sudo ufw allow ssh
  ```

### 2. **Comment résoudre une erreur "Permission Denied" lors de la connexion SSH ?**
- **Solution :** Vérifiez les permissions du fichier `authorized_keys` si vous utilisez des clés SSH :
  ```bash
  chmod 600 ~/.ssh/authorized_keys
  chmod 700 ~/.ssh
  ```
  Assurez-vous aussi que le paramètre `PermitRootLogin` est bien configuré dans `/etc/ssh/sshd_config` :
  ```
  PermitRootLogin yes
  ```
  Redémarrez ensuite le service SSH :
  ```bash
  sudo systemctl restart ssh.service
  ```

### 3. **Pourquoi le service WinRM ne fonctionne pas sur Windows Server ou Windows 10 ?**
- **Solution :** Assurez-vous que WinRM est configuré et que le service est démarré :
  ```powershell
  Start-Service -Name WinRM
  Enable-PSRemoting -Force
  ```
  Vérifiez également que le pare-feu autorise les connexions WinRM :
  ```powershell
  New-NetFirewallRule -Name "WinRM-HTTP" -DisplayName "Windows Remote Management (HTTP-In)" -Enabled True -Direction Inbound -Protocol TCP -LocalPort 5985
  ```

### 4. **Comment résoudre un problème de connexion réseau avec Ubuntu 24 ou Debian 12 ?**
- **Solution :** Redémarrez le service réseau :
  ```bash
  sudo systemctl restart networking
  ```
  Vérifiez aussi la configuration réseau avec :
  ```bash
  ip addr show
  ```

### 5. **Je reçois une erreur "Access Denied" lors de l'utilisation de PowerShell sur Windows 10, que faire ?**
- **Solution :** Modifiez les paramètres d'exécution de PowerShell pour autoriser les scripts :
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
  ```

### 6. **Pourquoi mon utilisateur administrateur local ne peut pas accéder aux fichiers du réseau ?**
- **Solution :** Assurez-vous que le compte est bien ajouté au groupe des administrateurs :
  ```powershell
  Add-LocalGroupMember -Group "Administrateurs" -Member "Administrator"
  ```
  Vérifiez également la configuration du profil réseau :
  ```powershell
  $Index = (Get-NetConnectionProfile).InterfaceIndex
  Set-NetConnectionProfile -InterfaceIndex $Index -NetworkCategory Private
  ```

### 7. **Comment installer des mises à jour via PowerShell sur Windows Server 2022 ?**
- **Solution :** Installez et utilisez le module `PSWindowsUpdate` :
  ```powershell
  Install-Module -Name PSWindowsUpdate -Force -Confirm:$false
  Get-WindowsUpdate -Install -AcceptAll -AutoReboot
  ```

### 8. **Comment cloner la configuration SSH d'un serveur Linux vers d'autres serveurs ?**
- **Solution :** Utilisez `rsync` ou `scp` pour copier le fichier de configuration `/etc/ssh/sshd_config` vers d'autres serveurs :
  ```bash
  scp /etc/ssh/sshd_config user@remote:/etc/ssh/sshd_config
  ssh user@remote 'sudo systemctl restart ssh.service'
  ```

### 9. **Comment ajouter un dépôt GitHub sur Debian ou Ubuntu ?**
- **Solution :** Clonez le dépôt dans le répertoire souhaité :
  ```bash
  git clone https://github.com/WildCodeSchool/TSSR-2409-JAUNE-P2-G2-TheScriptingProject.git
  ```

### 10. **Que faire si le pare-feu bloque l'accès au service sur Windows ?**
- **Solution :** Autorisez le service à travers le pare-feu avec PowerShell :
  ```powershell
  Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"
  ```
