# git-utils

= Utilisation =
== Pré-requis ==
Pour utiliser ces scripts :
* Il faut ajouter dans .gitattributes : <code>*.java diff=java</code>
* Il faut également que le dossier target soit existant et rempli avec les fichiers compilés des classes à analyser.

=== Analyse d'une classe spécifique ===
Le script analyse_classe.sh est à utiliser pour faire l'analyse d'une classe spécifique. Ce script va :
* Créer un dossier "Analyse_code_[nomClasse]/" dans lequel on aura
** Un fichier "listeMethodes_$nomFichier.log" listant les méthodes de la classe choisie
** Un fichier "listeMethodesSeules_$nomFichier.log" listant uniquement les noms des dites méthodes
** Un dossier "diffs/" dans lequel on aura des fichiers "diff_$nomFichier_$methodName.log" donnant les différents changements effectués sur chaque méthode depuis la date précisée dans analyse_code.sh.
* Créer un fichier csv listant pour chaque méthode le nombre de modifications depuis la date précisée auparavant dans analyse_code.sh.

=== Analyse d'un dossier complet ===
Pour analyser un dossier complet, on utilise le script analyse_folder.sh.
* Ce script itère sur les différents dossiers et sous-dossiers du dossier passé en paramètre grâce à analyse_final_folder.sh  et exécute le script précédent (analyse_classe.sh).
* L'ensemble des informations obtenues par les différentes exécutions du script analyse_classe.sh sont enregistrées dans un dossier "Analyse".
* Un fichier csv contenant l'ensemble des informations des différents fichiers csv précédents est créé.

== Exemples d'utilisation ==
=== analyse_classe.sh ===
Ce script prend en paramètre d'entrée :
* n : le nom du fichier à analyser
* t : le fichier .class correspondant, se situant dans le dossier target/
* j : le fichier .java correspondant, se situant dans le dossier src/
* d : la date à partir de laquelle on cherche les différents commits effectués. Par défaut, cette date est le 01/01/2014.

=== analyse_folder.sh ===
Ce script prend en paramètre d'entrée :
* f : le chemin vers le dossier à analyser.
