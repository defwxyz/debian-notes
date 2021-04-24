## Notes à propos du langage Haskell

Comment installer le langage sous debian linux.

Lisez la page https://docs.haskellstack.org/en/stable/README/

Et suivez les instructions: 

```
wget -qO- https://get.haskellstack.org/ | sh
stack new my-project
cd my-project
stack setup
stack build
stack exec my-project-exe
```

Si vous rencontrez un problème de PATH et que le fichier .profile n'est pas lu (alors qu'il devrait l'être), peut-être que vous êtes dans un cas similaire à ce lui que j'ai eu. Je l'ai résolu en ajoutant le fichier .xsessionrc avec ce contenu:

```
$ cat .xsessionrc 
# .xsessionrc is evaluated once at display manager startup
if [ -f "${HOME}/.profile" ]; then # if and only if .profile exists
    . "${HOME}/.profile"
fi
```

Sur [la page wikipedia du langage Haskell](https://fr.wikipedia.org/wiki/Haskell) on apprend qu'il y a un [site officiel](https://www.haskell.org).

Une [liste des emplois en France où on fait référence au langage](https://fr.indeed.com/emplois?q=Haskell&l=France) : 25 entrées le 20 avril 2021 et si on regarde bien, aucune entrée ne concerne Haskell en particulier. 

J'ai [ajouté le programme](src/haskell/random-picture) pour créer des images aléatoires qui me sert pour apprendre le langage haskell. 

Cette image est
![image](./picture001.png) générée par le programme haskell random-picture

Pour convertir l'image svg en png, j'utilise `rsvg-convert` :

```
sudo apt install librsvg2-bin
rsvg-convert picture001.svg > picture001.png
```

Cette image est
![image](./picture002.png) générée aussi par le programme haskell random-picture





