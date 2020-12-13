
# moleLinux

## Installation

* Select the distribution of choice.
* Download the .iso.
* Burn the iso
  
```sh
lsblk # show available devices
dd if=<path to iso> of=/dev/sdX status="progress"
```

* Run the installer. If it's commandline install, then use documentation or there are some documentation in older mole<distro> repositories.

## After installation

* Boot into system
* If git is not on the system, install it.
* Go to $HOME/Documents/ and run

```sh
git clone https://github.com/moledoc/molelinux.git
```

* Run the setup script.

```sh
cd molelinux
sh .setup.sh
```

* check with package manager is used and make symbolic link to correct aliases file. For example

```sh
ln -s $HOME/.config/zsh/.zPkgAliases $HOME/.config/zsh/.aptAliases
ln -s $HOME/.config/zsh/.zPkgAliases $HOME/.config/zsh/.pacmanAliases
```

* The general setup should be done. Some tweaking might be necessary, but it is not covered in this readme.

## moleLinux setup

This subsection describes authors preferences in programs.
Also presents a list of most commonly used programs, fonts etc.

* doas over sudo, but if there is no doas option sudo works fine. Also, for doas and sudo both I use nopass option (using doas/sudo doesn't require password). Just my preference.
* xterm
* nvim
* firefox
* redshift
* hermit-font
* gruvbox colorscheme
* 

## TODO

* improve this README
* make this build
* Keep this build up-to-date

## Author

Written by
Meelis Utt
