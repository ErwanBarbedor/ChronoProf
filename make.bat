@echo off

rem UTF-8 config
chcp 65001 > nul

call plume main.plume --no-cache -p

if %ERRORLEVEL% equ 0 (
    start chrono.html
)
if %ERRORLEVEL% equ 1 (
    echo Une erreur est survenue durant l'exécution.
    echo Appuyez sur une touche pour fermer la fenêtre.
    pause > nul
)

