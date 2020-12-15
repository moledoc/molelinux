#!/bin/sh

# README: setup user system, after git pull. Needs one argument -- it should be package manager and it's install command. Eg "apt install"

# Download packages.
packages="xterm zsh zsh-syntax-highlighting vim firefox fzf keepassxc redshift xbindkeys htop fd-find ripgrep zathura zathura-pdf-mupdf mpv tmux vscode"
additional_pkg="neovim tilda vlc nitrogen thunar" 

if [ -z $1 ]
then
	exit(0)
else
	echo "Installed packages: $packages $additional_pkg"
	sudo $1 $packages $additional_pkg
fi

# swap esc and caps
setxkbmap -option caps:swapescape
echo "CapsLock and escape swapped"

# change shell to zsh
new_shell="zsh"
chsh -s $new_shell
echo "Shell changed to $new_shell"

# Copy contents of the repository to the right places.
# Make dir/ if necessary.

#if [ ! -d $HOME/.scripts ]
#then
#	mkdir $HOME/.scripts
#	echo "Created $HOME/.scripts"
#fi
if [ ! -d $HOME/.config ]
	mkdir $HOME/.config
	echo "Created $HOME/.config"
fi

cp -r .scripts .config $HOME
cp * $HOME

echo "Repo contents copied to $HOME and $HOME/.scripts, $HOME/.config"

# add symlink to package manager aliases
ln -s $HOME/.config/$new_shell/.zPmAliases $HOME/.config/$new_shell/.zAptAliases
echo "Symlink to package manager aliases created"

echo "Setup DONE!"

