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
