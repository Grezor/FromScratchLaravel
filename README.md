# FromScratchLaravel 

Ce projet propose une structure de départ robuste et modulable pour vos applications, entièrement configurée avec Docker.  


## Fonctionnalités principales

Le fichier `docker-compose.yml` configure les services suivants :  
- **PHP (lara-php)** : Conteneur pour exécuter PHP, accessible sur le port `9000`, avec le code source monté dans `/var/www/html/`.  

- **MySQL (lara-mysql)** : Conteneur pour la base de données, avec un mot de passe root par défaut (`noPassword`), un volume persistant pour les données, et accessible sur le port `3307`.  

- **phpMyAdmin (lara-pma)** : Une interface web simple pour gérer la base de données, disponible via le port `8080`.  
- **Réseau Docker** : Tous les conteneurs communiquent via un réseau dédié appelé `app_network`.  


## En savoir plus  

Si vous souhaitez explorer ou personnaliser la configuration :  
- **Consultez les dossiers** `docker/` et `bin/` pour les scripts et configurations spécifiques.  
- **Examinez le fichier** `docker-compose.yml` pour comprendre les services et leurs interactions.  
- **Référez-vous au fichier** `Makefile` pour découvrir les commandes utiles à l’exécution et à la gestion du projet.  

## file .env
```sh
# .env example

DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=fromScratchlaravel
DB_USERNAME=root
DB_PASSWORD=noPassword
```

## Makefile : Automatisation des tâches Docker

Un **Makefile** permet d’automatiser et de simplifier l’exécution de commandes dans votre projet Docker.  
Grâce au Makefile, vous pouvez remplacer des commandes longues et complexes par des raccourcis simples.
