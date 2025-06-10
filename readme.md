<p align="center"><img src="static/logo.svg" width=50%></p>

## Présentation

ChronoProf⏳ est un utilitaire destiné aux enseignants, permettant de générer une page web proposant une retrospectives de leurs anciens élèves, mêlants trombinoscopes et souvenirs.

C'est un moyen de centraliser les petits mots, dessins ou anecdotes qu'on accumule année après année, tout en permettant de facilement se remémorer des classes ou élèves.

Exemple de rendu (avec des images libres de droit):

<p align="center"><img src="exemple.png" width=70%></p>

La page web est entièrement locale, rien n'est envoyé en ligne.

ChronoProf⏳ est écrit principalement en [Plume🪶](https://github.com/ErwanBarbedor/PlumeScript), un langage de ma création.

## Compatibilité

ChronoProf est actuellement compatible exclusivement avec le système d'exploitation Windows et l'architecture x86.

Un portage vers Linux pourrait être envisagé si demande en est faîte.

Le portage vers macOS n'est pas prévu à ce stade.

## Installation et Lancement Initial

1.  Téléchargez la version la plus récente (volet de droite, section "Releases") de l'archive ChronoProf et la décompressez-la où vous voulez.
2. Vous obtenez un répértoire nommé `chronoprof-X.X.X-win-x86` (vous pouvez le renommer). Entrez dans ce répertoire.
3.  Créez un sous-répertoire nommé `data`.
4.  Organisez les photographies et autres souvenirs dans le sous-répertoire `data`, conformément à la structure détaillée ci-après.
5.  Quand toutes les photo ont été placé dans `data`, double cliquez sur `make.bat`.
6.  En cas de succès, le fichier devrait s'ouvrir dans votre navigateur. Il est également sauvegardé sour le nom `chrono.html`. Si ce n'est pas le cas, consultez les messages d'erreurs affichés dans la console.

Remarques:
- Le fichier `chrono.html` ne peux pas être déplacé librement, il dépend des autres dossiers présents dans le même répertoire.
- Si certaines photos souvenirs sont difficiles à lire, vous pouvez les agrandir en cliquant dessus.
- L'utilisateur est légalement responsable d'obtenir le consentement écrit des personnes identifiables sur les photographies, autorisant leur stockage et leur utilisation dans ChronoProf⏳.

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
Pour chaque élève disposant d'une photographie individuelle, un sous-répertoire portant son nom (`Jean Dupont`) peut être créé au même niveau que sa photo. Ce répertoire peut contenir des fichiers de souvenirs supplémentaires associés à cet élève:
- Images au format`.png`/`.jpg`.
- Textes (`.txt`) pour des anecdotes. Dans ces fichiers texte, vous pouvez mettre un passage en italique en l'entourant de `*`: `*texte en italique*`, ou en gras: `**texte en gras**`.

Exemple :
- `data/2024-2025/Gabriel Peri/3e2/Jean Dupont/dessin.png`
- Fichier `data/2024-2025/Gabriel Peri/3e2/Jean Dupont/anecdote.txt` qui contient:
```
Au *milieu du cours*, se lève et crie: **TAISEZ VOUS**.
Se tournant vers moi, il précise *sauf vous monsieurs*.
```

Les souvenirs seront affichés dans l'ordre alphabétique des noms des fichiers.

### Souvenirs de classe (optionnel)
Les souvenirs collectifs liés à une classe entière peuvent être placés dans un sous-répertoire nommé `classe` au sein du répertoire de la classe concernée.
Exemple : `data/2024-2025/Gabriel Peri/3e2/classe/`

### Sous-répertoires `illustration`
Il est possible, dans n'importe quel répertoire, de créer un dossier `illustration`.

Par exemple, `data/2024-2025/illustration` ou `data/2024-2025/Gabriel Peri/3e2/illustration`.

Les images qu'il contient seront aléatoirement disposés parmis les photos des élèves.

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
En cas d'erreur de syntaxe rendant un fichier `config.lua` invalide, vous pouvez le supprimer. ChronoProf le recréera avec les valeurs par défaut lors de sa prochaine exécution.

Si le dossier contient uniquement `return {}`, aucune option n'est encore disponible.