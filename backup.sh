#!/usr/bin/env sh

dest='./src'

# Prepare src
mkdir -p ${dest}
rm -rf ${dest}/*

# Fish
mkdir -p ${dest}/fish
cp ~/.config/fish/config.fish ${dest}/fish
cp -r ~/.config/fish/functions/ ${dest}/fish

# Compton
mkdir -p ${dest}/compton
cp ~/.config/compton/compton.conf ${dest}/compton

# i3
mkdir -p ${dest}/i3
cp ~/.config/i3/config ${dest}/i3

# Emacs
mkdir -p ${dest}/emacs
cp ~/.emacs ${dest}/emacs

# Conky
mkdir -p ${dest}/conky
cp ~/.conkyrc ${dest}/conky

# Bin
mkdir -p ${dest}/bin
for f in ~/bin/*; do
    [[ ! -L $f ]] && cp $f ${dest}/bin
done
cp -P ~/bin/__lemonbar_init__ ${dest}/bin
cp -r ~/bin/i3 ${dest}/bin

