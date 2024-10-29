# Projet d'Exécution de Scripts à Distance

## 1. Description des Scripts

### PowerShell

Le script PowerShell s'exécute sur un serveur **Windows Server 2022**, sous **PowerShell Core** (dernière version LTS). Ce script peut avoir plusieurs dépendances de fichiers.

### Shell

Le script shell s'exécute sur un serveur **Debian 12** et utilise les commandes et instructions **Bash**. Ce script peut également avoir plusieurs dépendances de fichiers.

## 2. Interface Utilisateur

À l'exécution, un menu s'affiche, proposant une navigation ergonomique avec des sous-menus dans lesquels l'utilisateur peut choisir ce dont il a besoin :

- **Cible** : Cela peut être un ordinateur ou un utilisateur.
- **Choix d'actions** : Choisir une ou plusieurs actions à effectuer ou rechercher des informations.

### Cibles

- **Utilisateur** :
  - Nom partiel ou complet
  - Validation
- **Ordinateur** :
  - Nom complet ou adresse IP
  - Validation

### Actions

On choisit une action, et le script l'exécute :

- **Actions sur les utilisateurs** :
  - Création de compte
  - Changement de mot de passe
  - Suppression de compte
  - Désactivation de compte
  - Ajout à un groupe d'administration
  - Ajout à un groupe local
  - Sortie d’un groupe local
- **Actions sur les ordinateurs clients** :
  - Arrêt
  - Redémarrage
  - Verrouillage
  - Mise-à-jour du système
  - Création de répertoire
  - Suppression de répertoire
  - Prise de main à distance (GUI)
  - Définition de règles de pare-feu
  - Activation du pare-feu
  - Désactivation du pare-feu
  - Installation de logiciel
  - Désinstallation de logiciel
  - Exécution de script sur la machine distante

### Informations

On choisit une information ou un lot d’informations :

- Pour une seule : affichage de l’information et enregistrement
- Pour plusieurs : enregistrement

#### Informations sur les utilisateurs

- Date de dernière connexion d’un utilisateur
- Date de dernière modification du mot de passe
- Liste des sessions ouvertes par l'utilisateur
- Droits/permissions de l’utilisateur sur un dossier
- Droits/permissions de l’utilisateur sur un fichier

#### Informations sur les ordinateurs clients

- Version de l'OS
- Nombre d'interface
- Adresse IP de chaque interface
- Adresse Mac
- Liste des applications/paquets installées
- Liste des utilisateurs locaux
- Type de CPU, nombre de coeurs, etc.
- Mémoire RAM totale
- Utilisation de la RAM
- Utilisation du disque
- Utilisation du processeur
- Liste des ports ouverts
- Statut du pare-feu

Les informations recueillies sur la cible (utilisateur ou ordinateur) sont enregistrées dans un fichier nommé `info_<Cible>_<Date>.txt`, avec les spécifications suivantes :

- `<Cible>` : Nom d’utilisateur ou d’ordinateur cible.
- `<Date>` : Date du recueil des informations au format **yyyymmdd**.

## 3. Enregistrement des Informations

Les traces des activités effectuées sont enregistrées dans un fichier `log_evt.log`, qui contient un enregistrement textuel de toutes les activités de navigation dans les menus du script, ainsi que les demandes d’informations et les actions effectuées.

### Informations enregistrées

Les informations consignées dans le fichier journal comprennent des éléments factuels tels que :

- Date
- Heure
- Utilisateur concerné
- Utilisateur distant
- Ordinateur distant

### Emplacement des fichiers journal

- Pour le serveur Windows : `C:\Windows\System32\LogFiles`
- Pour le serveur Linux : `/var/log`

### Format des enregistrements

Les enregistrements dans le fichier `log_evt.log` suivent le format :

`yyyymmdd-hhmmss-Utilisateur-Evenement`

```

<Date>-<Heure>-<Utilisateur>-<Evenement>

```

Avec :

- `<Date>` : **yyyymmdd**
- `<Heure>` : **hhmmss**
- `<Utilisateur>` : Nom de l’utilisateur exécutant le script
- `<Evenement>` : Action effectuée

### Entrées Spéciales

La première entrée de journal (lancement du script) et la dernière (sortie du script) sont indiquées par des lignes spéciales :

```

<Date>-<Heure>-<Utilisateur>-********StartScript********
<Date>-<Heure>-<Utilisateur>-*********EndScript*********

```
