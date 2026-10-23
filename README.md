This is just an app launcher with cat ears
======
Enjoy your app launcher with minimal cat ears and smooth transition\
Comes default with rose-pine-moon theme but you can customize them in the shell.qml (=^･ω･^=)b\
Defualt font is mononoki but you can change them in Components/Text.qml

<img source="data/demo.gif" width = 400>


# Installation
just make a directory and clone this repo and put it in \$HOME/.config/quickshell/ \
also make sure you have quickshell installed and no shell.qml in \$HOME/.config/quickshell/

```sh
mkdir -p $HOME/.config/quickshell/cat-app-launcher
git clone https://github.com/SleepyCat3929/cat-app-launcher.git $HOME/.config/quickshell/
```
\
if you don't have quickshell installed then follow this [quickshell installation guide](https://quickshell.org/docs/v0.3.0/guide/install-setup/)

# Usage
use qs with the directory name you created\
and bind them with your keyboard shortcut and you should be good to go! ~(=\^‥\^)/

in this case if you follow the [installation](#installation) the name should be cat-app-launcher
```sh
qs -c cat-app-launcher
```

if you have custom directory name then
```sh
qs -c <custom-dir-name>
```

# Customization
you can customize a little bit of the appearence of the color in shell.qml file\
you can also change font in Components/Text.qml

for example if you wanna change the border thickness just change this part of the file (it should be at somewhat top part of the file)
```qml
property real border_width: 3 
```
change this into whatever you like (in this case let's say 10)
```qml
property real border_width: 10
```
then save the file and run the quickshell again and you should see the changes  (^- ᴗ - ^｡=)~
