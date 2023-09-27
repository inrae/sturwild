# Traduction des libellés en anglais

## Base de données

Génération du script de traduction :

- transformer les feuilles du fichier `dbtranslate.ods` en fichiers csv (séparateur : point-virgule) : `tables.csv` et `colonnes.csv`
- Lancer le script de génération des commandes SQL de modification :

```bash
php generatesql.php
```

- exécuter le script généré (`translate.sql`)
- générer le fichier de modification de la structure de la base de données à partir du modèle pgModeler (fichier `alter-translate-v23.0.sql`)
  - le vérifier
  - l'exécuter
-
