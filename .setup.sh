#!/bin/sh

# README: setup user system, after git pull.

# Set up root passwd
echo "Set root passwd"
sudo passwd

# update repository
updateCmd="sudo apt update;sudo apt upgrade"
installCmd="apt install"

# Download packages.
packages="xterm zsh zsh-syntax-highlighting vim firefox fzf keepassxc redshift xbindkeys htop fd-find ripgrep zathura zathura-pdf-poppler mpv tmux"
additional_pkg="neovim guake vlc nitrogen nemo" #tilda

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
new_shell="zsh"
echo "Changing shell to $new_shell"
chsh -s /bin/$new_shell
echo "Shell changed to $new_shell"

# set up git
echo "Setting up git for user"
echo "Insert git --global user.name: " varUsername
git config --global user.name "$varUsername"
echo "Insert git --global user.email: " varEmail
git config --global user.email "$varEmail"
echo "Minimal git config set up"

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

