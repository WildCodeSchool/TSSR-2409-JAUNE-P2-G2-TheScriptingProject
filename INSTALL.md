# Documentation Administrateur

## 1. Prérequis Techniques

# 1. Prérequis Technique
  * 1 Serveur Windows nommé SRVWIN01
    * en windows serveur 2022 avec les dernieres mise a jour et les firewall desactivé 
  * 1 Client Windows nommé CLIWIN01
    * en Windows 10 avec les dernieres mise a jour et les firewall desactivé
  * 1 Serveur Dedian nommé SRVLX01
    * en Dedian 12 avec les dernieres mise a jour et les firewall desactivé
  * 1 en Ubuntu nommé CLILIN01
    * en Ubunto 24.04 LTS avec les dernieres mise a jour et les firewall desactivé

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
## 2. Étapes d'installation

1. **Cloner le dépôt sur le serveur dans le dossier de votre choix :**
    ```bash
    git clone git@github.com:WildCodeSchool/TSSR-2409-JAUNE-P2-G2-TheScriptingProject.git
    ```

2. **À continuer...**

## 3. Configuration

- À compléter en fonction des besoins de configuration spécifiques.

## 4. FAQ

### 1. Problèmes connus et solutions courantes liés à l'installation et à la configuration :
- [FAQ](#4-faq)


- [Prérequis Techniques](#1-prérequis-techniques)
- [Étapes d'installation](#2-etapes-dinstallation)
- [Configuration](#3-configuration)
