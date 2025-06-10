-- Main config
return {
    pictureHeight  = 160, -- Hauteur, en pixel, des photos individuelles
    fontSizeFactor = 100, -- mise à l'échelle des polices. 200 double la taille de tout les textes, 50 la divise par 2.

    showName    = false, -- Afficher le nom de famille des élèves
    showSurname = true,  -- Afficher le prénom de famille des élèves

    showMultipleGroup = true, -- Affiche un marqueur à côté des élèves présents dans plusieurs classes

    --- Illustrations
    -- De manière optionnelle, vous pouvez dans n'importe quel dossier créer
    -- un sous dossier "illustrations" qui serviront à décorer le document final.

    illustrationBlend = true, -- Uniquement si vos illustrations sont en noir et blanc. Si vaut "true", la partie blanche de l'illustration sera remplacée par le background.

    illustrationTopGroup       = true, -- Mettre une illustration en tête de chaque groupe 
    illustrationBetweenStudent = true, -- Mettre des illustrations au milieu des trombinoscopes
    illustrationMinRange = 4, -- Au minimum, il y aura ... photos entre chaque illustration insérée
    illustrationMaxRange = 8, -- Au maximum, il y aura ... photos entre chaque illustration insérée
}