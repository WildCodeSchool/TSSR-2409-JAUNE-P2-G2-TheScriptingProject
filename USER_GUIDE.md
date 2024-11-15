# Documentation Utilisateur

1. [Utilisation de base](#1-utilisation-de-base)
   - Script Bash Shell
   - Script PowerShell
2. [Comment utiliser les fonctionnalités clés](#2-comment-utiliser-les-fonctionnalités-clés)
   - Utilisation du script
3. [Comment utiliser au mieux les options](#3-comment-utiliser-au-mieux-les-options)
4. [FAQ](#4-faq)

---

# 1. Utilisation de base

### Exécution du script avec Debian 12

1. Après l'ouverture du serveur Debian 12 et votre authentification, placez-vous à l'emplacement où se trouve le script.  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-15%20092635.png)  

2. Exécutez le script avec son nom :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-15%20092713.png)  

3. Connectez-vous au compte client :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-15%20092822.png)  
   ![](./assets/Capture%20d'%C3%A9cran%202024-11-15%20092831.png)  

4. Vous pouvez désormais naviguer dans le script :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-15%20092852.png)  

### Exécution du script avec PowerShell Core 7

1. Recherchez "PowerShell 7" dans la barre de recherche Windows :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-14%20203934.png)  

2. Exécutez PowerShell 7 :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-14%20204009.png)  

3. Placez-vous à l'emplacement du script :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-14%20204047.png)  

4. Exécutez le script avec son nom :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-14%20204334.png)  

5. Vous pouvez désormais naviguer dans le script :  

   ![](./assets/Capture%20d'%C3%A9cran%202024-11-14%20204059.png)  

---

# 2. Comment utiliser les fonctionnalités clés

Il vous suffit de lancer le script et de naviguer dans les différents menus. Pour chaque action ou information demandée, le script affichera le résultat ou exécutera l'action choisie.  

![Menu PowerShell](./assets/ActionOrdinateurPS.png)  

---

# 3. Comment utiliser au mieux les options

Le script propose des fonctionnalités avancées, comme la requête de plusieurs informations. Par exemple, si vous accédez au menu "Informations" et sélectionnez les options 1 et 3 (fonctionnalité disponible uniquement dans le script Bash au 14/11/2024) :

![Menu d'informations utilisateur](./assets/menuInfoUtilisBash.png)  

Les informations seront enregistrées dans un fichier `.txt` situé dans :  
- Windows : `C:\Users\<Nom_utilisateur>\Documents\`
- Linux : `/home/<Nom_utilisateur>/Documents`

![Contenu du fichier texte](./assets/log.png)  
![](./assets/Capture%20d'%C3%A9cran%202024-11-15%20093054.png)  

Vous pouvez également consulter le journal du script, qui retrace toutes les actions effectuées. Ce journal est créé lors de la première exécution du script et contient un horodatage, le nom d'utilisateur et un message. Chaque session est délimitée par "********StartScript********" et "********EndScript********".

- Windows : `C:\Windows\System32\LogFiles`
- Linux : `/var/log/`

![Contenu du fichier log](./assets/Capture%20d'%C3%A9cran%202024-11-14%20212512.png)  

---

# 4. FAQ

### Q: Mon script ne fonctionne pas, que faire ?  
**A:** Vérifiez d'abord si votre machine est à jour.  
- **Sous GNU/Linux :**  
  ```bash
  sudo apt update && sudo apt upgrade
  ```
- **Sous Windows :**  
  Allez dans le Menu Windows, tapez "Mise à jour", sélectionnez la première option et cliquez sur "Rechercher des mises à jour".

Ensuite, vérifiez que vous avez les permissions nécessaires pour exécuter le script.  
- **Sous GNU/Linux :**  
  ```bash
  sudo bash /chemin/script.sh
  ```
- **Sous Windows :**  
  Faites un clic droit sur PowerShell et sélectionnez "Exécuter en tant qu'administrateur".

Si le problème persiste, supprimez et retéléchargez le script.

### Q: J'ai une erreur de connexion lors de la connexion à une machine distante, que faire ?  
**A:** C'est probablement une erreur d'adresse IP. Assurez-vous que vous utilisez la bonne adresse IP pour la machine distante. La machine cliente doit être sur le même réseau que la machine serveur. Vérifiez également les interfaces réseau.

### Q: Ma connexion à une machine distante est-elle sécurisée ?  
**A:** Oui !  
Nous utilisons des connexions sécurisées comme [SSH](https://fr.wikipedia.org/wiki/Secure_Shell) pour GNU/Linux, et la [connexion native PowerShell](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/invoke-command?view=powershell-7.4) pour Windows.

### Q: Rien ne s'affiche à l'écran, ma commande s'est-elle bien exécutée ?  
**A:** Consultez le fichier de journalisation pour vérifier.  
- **Sous GNU/Linux :** `/var/log/log_evt.log`
- **Sous Windows :** `C:\Windows\System32\LogFiles\log_evt.log`

Ce fichier vous permettra de voir si une erreur est survenue.
