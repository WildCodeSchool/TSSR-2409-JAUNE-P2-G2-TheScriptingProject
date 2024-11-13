#!/bin/bash

# Demande à l'utilisateur les informations nécessaires
read -p "Sur quel utilisateur voulez-vous vous connecter ? " user
read -p "Quelle est l'adresse IP de la machine cible ? " IP

# Transfert du script client.sh vers la machine distante
echo "Transfert du script client.sh en cours..."
scp ./client.sh "$user@$IP:/home/$user/client.sh"

# Vérification du transfert
if [ $? -eq 0 ]; then
    echo "Transfert réussi."
else
    echo "Échec du transfert. Vérifiez l'IP, l'utilisateur, ou la connexion réseau."
    exit 1
fi

# Exécution du script client.sh sur la machine distante
echo "Exécution du script sur la machine distante..."
ssh -t "$user@$IP" "/bin/bash -l /home/$user/client.sh"

# Vérification de l'exécution
if [ $? -eq 0 ]; then
    echo "Vous êtes connecté à $user sur la machine $IP."
else
    echo "Erreur lors de l'exécution du script sur la machine distante."
fi
