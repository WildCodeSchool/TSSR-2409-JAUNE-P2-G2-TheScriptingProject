# Exécution de scripts à distance - Projet du groupe 2

## Présentation du projet, objectifs finaux

Ce projet consiste à développer un script capable d’exécuter des tâches sur des machines distantes au sein d’un réseau local, avec une prise en charge de systèmes d’exploitation multiples.  
Les objectifs finaux sont de :

1. Assurer une exécution complète et fonctionnelle du script.
2. Fournir une documentation détaillée et correcte.
3. Présenter une démonstration finale validant ces points.

Le projet se divise en deux objectifs :

- **Objectif principal** : Utiliser un script PowerShell sur une machine Windows Server pour exécuter des tâches sur des machines Windows 10, et un script Bash sur une machine Debian pour agir sur des machines Ubuntu.
- **Objectif secondaire** : Étendre le projet pour permettre au serveur de cibler également une machine cliente avec un système d’exploitation différent.

## Introduction : mise en contexte

Dans le cadre de ce projet, nous cherchons à automatiser les tâches administratives sur plusieurs machines d’un réseau local. Ces tâches peuvent inclure des actions spécifiques ou des requêtes d’informations visant à simplifier la gestion et la supervision de l’infrastructure réseau.

L’infrastructure est hébergée sur **Proxmox**, une plateforme de virtualisation open-source, permettant une gestion centralisée et un déploiement flexible des différentes machines virtuelles nécessaires.

## Membres du groupe de projet (Sprint 1)

- **Scrum Master** : Mahmoud
- **Product Owner** : Erwan
- **Développeur** : Antoine
- **Développeur** : Matthias

## Choix techniques

### Les OS utilisés

- **Serveur principal** :
  - **Windows Server 2022** : pour exécuter le script PowerShell et cibler les machines Windows
  - **Debian 12** : pour exécuter le script Bash et cibler les machines Ubuntu
- **Machines cibles** :
  - **Windows 10** pour les machines Windows
  - **Ubuntu 24.04** pour les machines Linux

Ces choix permettent d’assurer la compatibilité des scripts avec les environnements les plus couramment utilisés dans les infrastructures réseau, tout en s’appuyant sur Proxmox pour faciliter la gestion et l’orchestration des machines.

## Difficultés rencontrées : problèmes techniques rencontrés

Nous avons rencontré plusieurs défis lors du développement et des tests :

- **Compatibilité des commandes** : Adaptation des commandes pour garantir une exécution cohérente entre les différents systèmes.
- **Configuration réseau sous Proxmox** : Difficultés à configurer correctement le réseau pour permettre la communication entre les machines virtuelles hébergées sous Proxmox.
- **Permissions d’exécution** : Certaines permissions étaient limitées, nécessitant des configurations spécifiques.

## Solutions trouvées : solutions et alternatives

Nous avons mis en place les solutions suivantes pour surmonter les défis rencontrés :

- **Configuration de pare-feu** : Adaptation des règles de pare-feu pour permettre une communication fluide entre les machines virtuelles.
- **Ajustements de compatibilité** : Ajustement des commandes et tests sur des machines cibles afin d’assurer leur exécution correcte.
- **Optimisation de la configuration réseau sous Proxmox** : Ajustement des paramètres réseau pour faciliter l'interopérabilité des machines au sein de l'infrastructure Proxmox.

## Améliorations possibles : suggestions d’améliorations futures

Pour perfectionner le projet, plusieurs améliorations sont envisageables :

- **Support pour des systèmes d’exploitation additionnels** : Étendre la prise en charge à d’autres systèmes pour des environnements plus diversifiés.
- **Automatisation de la configuration Proxmox** : Mettre en place des scripts d'automatisation pour le déploiement et la configuration réseau sous Proxmox, facilitant ainsi l’installation de nouvelles machines.
- **Optimisation des scripts** : Améliorer les performances des scripts pour réduire le temps d'exécution et optimiser l'utilisation des ressources.

---
