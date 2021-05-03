# Notes à propos de Debian Linux 10.9

### Installation de debian 10.9

Télécharger l'image iso de [debian](https://cdimage.debian.org/debian-cd/current/amd64/iso-dvd/) et vérification de la somme de contrôle:

```
sha256sum debian-10.9.0-amd64-DVD-1.iso 
c92da2e33afe9c248a9396b8849d9f626b337676f81fd28e7b48f83492fd23fd  debian-10.9.0-amd64-DVD-1.iso
```

Commande pour créer une clef usb bootable:

`dd if=debian-10.9.0-amd64-DVD-1.iso of=/dev/sd??? bs=32M`


Après l'installation de l'environnement cinnamon, ctrl-alt-F4 pour se connecter sur une console en mode texte.
Le premier démarrage montre un écran noir car il n'y a pas le driver de la carte graphique.

### sudoers.d

Ajout d'un fichier myuser dans `/etc/sudoers.d`

Contenant une ligne 

```
myuser ALL=(ALL:ALL) NOPASSWD:ALL:
```

### drivers

Ajout des repositories non-free dans `/etc/apt/sources.list`

```
deb http://security.debian.org/debian-security buster/updates main contrib
deb-src http://security.debian.org/debian-security buster/updates main contrib

deb http://{{host}}/debian/ buster main contrib non-free
deb-src http://{{host}}/debian/ buster main contrib non-free
deb http://{{host}}/debian/ buster-updates main contrib non-free
deb-src http://{{host}}/debian/ buster-updates main contrib non-free
```

Et après `sudo apt-get update`, installation des drivers:

```
sudo apt install firmware-amd-graphics
sudo reboot
```

### Cinnamon

Pour ajouter des icônes sur le bureau, aller dans le "Menu" puis cliquer sur une application et faire un clic droit et choisir "Ajouter au bureau"

#### imprimante 

Ajouter l'imprimante via son adresse IP.

#### scanner

Il faut installer plug-in correspondant à la version de hplib installé sous debian.

On récupère les fichiers à l'url suivante: https://developers.hp.com/hp-linux-imaging-and-printing/plugins

Puis on installe le plugin avec la commande `hp-plugin -i`

Une fois que tout est installé on peut utiliser le scanner.

```
$ hp-makeuri 192.168.0.xxx 
$ sudo apt install xsane 
$ xsane "hpaio:/net/HP_LaserJet_Pro?ip=192.168.0.xxx"
```
#### radio

Sous Rhythmbox, Radio, Ajouter: 

http://icecast.radiofrance.fr/franceinter-hifi.aac

Puis ajuster les propriétés pour donner un nom idoine.

On trouve les URLs à l'url suivante: https://doc.ubuntu-fr.org/liste_radio_france

### packages


```
# Lister les packages installés via la commande: 
sudo dpkg-query -l --no-pager
# Installer un package
sudo apt install vim-gtk3
```


