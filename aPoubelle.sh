if confirmation; then
            connexion
            read -p "Veuillez entrer le nom de l'utilisateur pour connaître la date de sa dernière connexion" userco
            if cat /etc/passwd | grep $userco >/dev/null; then
                last -F -w -R $userco | grep 'seat0' | awk 'NR==1'
                echo "[$(date +%Y/%m/%d-%H:%M:%S)]-$USER-Vous avez choisi l'information 'Date de dernière connexion d’un utilisateur'" >>$log_file
            else
                echo "L'utilisateur n'existe pas"
                afficher_erreur
            fi
        fi


#!/bin/bash

# Demande à l'utilisateur les informations nécessaires
read -p "Sur quel utilisateur voulez-vous vous connecter ?" user
read -p "Quelle est l'adresse IP de la machine cible ?" IP

# Transfert du script client.sh vers la machine distante
echo "Transfert du script vers $IP en cours..."
scp ./client.sh "$user@$IP:/home/$user/client.sh"

# Vérification du transfert
if [ $? -eq 0 ]; then
    echo "Transfert réussi."
    echo
else
    echo "Échec du transfert. Vérifiez l'IP, l'utilisateur, ou la connexion réseau."
    exit 1
fi

echo "Exécution du script sur la machine distante..."
echo

# Vérification et exécution du script client.sh sur la machine distante
if [ $? -eq 0 ]; then
    echo "Vous êtes connecté à $user sur la machine $IP."
    echo
    echo
    ssh -t "$user@$IP" "/bin/bash -l /home/$user/client.sh"
else
    echo "Erreur lors de l'exécution du script sur la machine distante."
fi
