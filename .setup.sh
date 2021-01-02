#!/bin/sh

# README: setup user system, after git pull.

# Set up root passwd
echo "Set root passwd"
sudo passwd

# update repository
# CHANGE ACCORDING TO PACKAGE MANAGER!!!
updateCmd="sudo apt update;sudo apt upgrade"
installCmd="apt install"

# Download packages.
packages="xterm zsh zsh-syntax-highlighting guake neovim vim firefox fzf keepassxc redshift xbindkeys htop fd-find ripgrep zathura zathura-pdf-poppler mpv tmux nemo xclip"
additional_pkg="vlc nitrogen dconf-cli wmctrl" #tilda
# dconf-cli to load cinnamon keyboard shortcuts in/out
# wmctrl to list window processes

if [ ! -z "$installCmd" ]
then
	echo "Installing packages: $packages $additional_pkg"
	sudo $installCmd $packages $additional_pkg
  echo "Packages installed"
else
	echo "Missing argument, exiting script!"
	exit
fi

# swap esc and caps
setxkbmap -option caps:swapescape
echo "CapsLock and escape swapped"

# change shell to zsh
# echo "What user's shell do we change?"
# read user
# # TODO: check if user exists
new_shell="zsh"
echo "Changing shell to $new_shell"
chsh -s /bin/$new_shell
echo "Shell changed to $new_shell"

# set up git
echo "Setting up git for user"
echo "Insert git --global user.name: " 
read varUsername
git config --global user.name "$varUsername"
echo "Insert git --global user.email: " 
read varEmail
git config --global user.email "$varEmail"
echo "Minimal git config set up"

# create ssh key for github
echo "Create ssh key for accessing git."
mkdir $HOME/.ssh
ssh-keygen -t rsa -b 4096 -C "$varEmail" -f $HOME/.ssh/github_key -P ""
# change git remote from https to ssh
echo "Change git remote from https to ssh"
git remote set-url origin git@github.com:moledoc/molelinux.git  
echo "Copy github_key.pub to clipboard"
xclip -selection clipboard < $HOME/.ssh/github_key.pub

# Copy contents of the repository to the right places.
cp -r .scripts .config $HOME
# cp .setup.sh .x* .X* .z* $HOME
cp .* $HOME
echo "Repository contents copied to $HOME"

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


# # make guake dropdown terminal autostarting
# echo "Make guake dropdown terminal autostarting"
# sudo cp /usr/share/applications/guake.desktop /etc/xdg/autostart

echo "Setup DONE!"
echo "Visit github repo and add the ssh public key to allowed ssh keys (public key should be copied to the clipboard)!"
