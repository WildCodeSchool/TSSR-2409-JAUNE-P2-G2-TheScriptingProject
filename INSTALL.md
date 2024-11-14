# Documentation Administrateur

## Table des matières
1. [Prérequis Techniques](#1-prérequis-techniques)
   - [Prérequis pour Debian 12](#prérequis-pour-debian-12)
   - [Prérequis pour Ubuntu 24](#prérequis-pour-ubuntu-24)
   - [Prérequis pour Windows server 22](#prérequis-pour-windows-server-22)
   - [Prérequis pour Windows 10](#prérequis-pour-windows-10-pro)
3. [Étapes d'Installation](#2-étapes-dinstallation)
   - [Installation pour Linux](#pour-linux)
   - [Installation pour Windows](#pour-windows)
4. [Configuration](#3-configuration)
5. [FAQ](#4-faq)

---

## 1. Prérequis Techniques

### Prérequis pour Debian 12

1. **Installer le service SSH :**

   ```bash
   sudo apt update
   sudo apt install -y openssh-server git
   ```

### Prérequis pour Ubuntu 24

**Installer Git :**

   ```bash
   sudo apt update
   sudo apt install ufw
   ```

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

- **Cloner le dépôt sur le serveur dans le dossier de votre choix :**
    ```bash
    git clone git@github.com:WildCodeSchool/TSSR-2409-JAUNE-P2-G2-TheScriptingProject.git
    ```
### Pour Windows

- **Cloner le dépôt sur le serveur dans le dossier de votre choix :**
    ```powershell
    git clone git@github.com:WildCodeSchool/TSSR-2409-JAUNE-P2-G2-TheScriptingProject.git
    ```

---

## 3. Configuration

- **Serveur Windows** nommé `SRVWIN01`
  - Windows Server 2022 avec les dernières mises à jour appliquées et le pare-feu désactivé
- **Client Windows** nommé `CLIWIN01`
  - Windows 10 avec les dernières mises à jour appliquées et le pare-feu désactivé
- **Serveur Debian** nommé `SRVLX01`
  - Debian 12 avec les dernières mises à jour appliquées et le pare-feu désactivé
- **Client Ubuntu** nommé `CLILIN01`
  - Ubuntu 24.04 LTS avec les dernières mises à jour appliquées et le pare-feu désactivé
    
---

## 4. FAQ
