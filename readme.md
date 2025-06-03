<p align="center"><img src="logo.png"></p>

ChronoProf est un utilitaire destiné aux enseignants, permettant de générer des rétrospectives chronologiques à partir de collections de photographies.

## Compatibilité

ChronoProf est actuellement compatible exclusivement avec le système d'exploitation Windows.
Un portage vers Linux pourrait être envisagé si demande en est faîte. Le portage vers macOS n'est pas prévu à ce stade.

## Installation et Lancement Initial

1.  Créer un nouveau répertoire dédié à l'application.
2.  Télécharger la version la plus récente de l'archive ChronoProf et la décompresser dans le répertoire précédemment créé.
3.  Dans ce même répertoire, créer un sous-répertoire nommé `data`.
4.  Organiser les photographies et autres souvenirs dans le sous-répertoire `data`, conformément à la structure détaillée ci-dessous.

## Organisation du répertoire `data`

La structuration correcte du répertoire `data` est essentielle au bon fonctionnement de l'application.

### Répertoire racine `data`
Ce répertoire centralise toutes les données.

### Sous-répertoires années scolaires
Au sein de `data`, créer un sous-répertoire pour chaque année scolaire.
Exemple : `data/2024-2025/`

### Sous-répertoires d'établissement
Chaque répertoire d'année scolaire doit contenir un sous-répertoire par établissement fréquenté durant cette période.
Exemple : `data/2024-2025/Gabriel Peri/`

### Sous-répertoires de classe/groupe
Au sein de chaque répertoire d'établissement, créer un sous-répertoire par classe ou groupe.
Exemple : `data/2024-2025/Gabriel Peri/3e2/`

### Fichiers individuels d'élèves
Dans chaque répertoire de classe/groupe, placer les photographies individuelles des élèves. Un seul fichier image (`.png` ou `.jpg`) par élève, nommé `Jean Dupont.extension`.
Exemple : `data/2024-2025/Gabriel Peri/3e2/Jean Dupont.png`

### Dossiers individuels d'élèves (optionnel)
Pour chaque élève disposant d'une photographie individuelle, un sous-répertoire portant son nom (`Jean Dupont`) peut être créé au même niveau que sa photo. Ce répertoire peut contenir des fichiers de souvenirs supplémentaires associés à cet élève (images `.png`/`.jpg`, textes `.txt` pour des anecdotes, etc.).

Exemple : `data/2024-2025/Gabriel Peri/3e2/Jean Dupont/anecdote.txt`, `data/2024-2025/Gabriel Peri/3e2/Jean Dupont/dessin.img`

Les noms des fichiers n'ont pas d'importance.

### Souvenirs de classe (optionnel)
Les souvenirs collectifs liés à une classe entière peuvent être placés dans un sous-répertoire nommé `classe` au sein du répertoire de la classe concernée.
Exemple : `data/2024-2025/Gabriel Peri/3e2/classe/`

### Sous-répertoires `illustration`
Il est possible, dans n'importe quel répertoire, de créer un dossier `illustration`.

Par exemple, `data/2024-2025/illustration` ou `data/2024-2025/Gabriel Peri/3e2/illustration`.

Les images qu'il contient seront aléatoirement disposés parmis les photos des élèves.

Les images doivent être en noir et blanc purs (`#000` ou `#fff`).

## Configuration

Suite à la première exécution de ChronoProf, des fichiers de configuration `config.lua` seront générés automatiquement dans certains répertoires de la structure `data`.

Ces fichiers permettent de personnaliser certains aspects de la rétrospective. Les paramètres modifiables sont documentés par des commentaires directement dans les fichiers.

Il est impératif de respecter la syntaxe Lua lors de la modification de ces fichiers :
```lua
return { -- Ligne initiale à ne pas modifier
    -- Les lignes débutant par "--" sont des commentaires et sont ignorées.

    color = { -- Toute accolade ouvrante doit avoir une accolade fermante correspondante.
        r = 50, -- Chaque ligne de paramètre, sauf la dernière d'un bloc, se termine par une virgule.
        g = 70, -- Seule la valeur (ex: 70) est modifiable, pas le nom du paramètre (ex: "g =").
        b = 40
    }
}
```
En cas d'erreur de syntaxe rendant un fichier `config.lua` invalide, celui-ci peut être supprimé. ChronoProf le recréera avec les valeurs par défaut lors de sa prochaine exécution.

## État du projet

ChronoProf est un projet en cours de développement.

## Mentions légales

L'utilisateur est légalement responsable d'obtenir le consentement écrit des personnes identifiables sur les photographies, autorisant leur stockage et leur utilisation dans le cadre privé de cet outil.