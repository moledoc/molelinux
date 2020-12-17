#!/bin/sh

# README: setup user system, after git pull.

# update repository
updateCmd="sudo apt update;sudo apt upgrade"
installCmd="apt install"

# Download packages.
packages="xterm zsh zsh-syntax-highlighting vim firefox fzf keepassxc redshift xbindkeys htop fd-find ripgrep zathura zathura-pdf-poppler mpv tmux"
additional_pkg="neovim guake vlc nitrogen nemo" #tilda

if [ ! -z "$installCmd" ]
then
	echo "Installed packages: $packages $additional_pkg"
	sudo $installCmd $packages $additional_pkg
else
	echo "Missing argument, exiting script!"
	exit
fi

# swap esc and caps
setxkbmap -option caps:swapescape
echo "CapsLock and escape swapped"

# change shell to zsh
new_shell="zsh"
echo "Changing shell to $new_shell"
chsh -s /bin/$new_shell
echo "Shell changed to $new_shell"

# Copy contents of the repository to the right places.
# Make dir/ if necessary.

#if [ ! -d $HOME/.scripts ]
#then
#	mkdir $HOME/.scripts
#	echo "Created $HOME/.scripts"
#fi
if [ ! -d $HOME/.config ]
then
	mkdir $HOME/.config
	echo "Created $HOME/.config"
fi

cp -r .scripts .config $HOME
cp .setup.sh .x* .X* .z* $HOME

echo "Repo contents copied to $HOME, $HOME/.scripts and $HOME/.config"

# add symlink to package manager aliases
ln -s $HOME/.config/$new_shell/.zAptAliases $HOME/.config/$new_shell/.zPmAliases
echo "Symlink to package manager aliases created"

# install VimPlug (nvim/vim pluggin manager)
echo "Install VimPlug to $HOME/.config/nvim/plugged"
mkdir -p $HOME/.config/nvim/plugged
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs\
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Run PlugInstall, to install defined pluggins to neovim"
nvim +PlugInstall +qa

# add gruvbox for vim as well
echo "Add gruvbox colorscheme to vim colors"
sudo cp $HOME/.config/nvim/plugged/gruvbox/colors/gruvbox.vim /usr/share/vim/vim81/colors


# make guake dropdown terminal autostarting
echo "Make guake dropdown terminal autostarting"
sudo /usr/share/applications/guake.desktop /etc/xdg/autostart

echo "Setup DONE!"

