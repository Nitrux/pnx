# pnx [![Build Status](https://travis-ci.org/Nitrux/pnx.svg?branch=master)](https://travis-ci.org/Nitrux/pnx)

Wakka-wakka.

What is pnx
========
pnx (lowercase; originally Pacman for Nitrux) allows users to install software from Linux distributions that use the Pacman package manager on other Linux distributions that don’t use it without interfering with the distributions default package manager.

What pnx isn't
========

   - pnx is not a _new_ package manager.
   - pnx is not an Arch Linux container.
   - pnx is not an Arch Linux virtual machine.
   - pnx is not an Arch Linux installer.

How it works
========
pnx works by acting as a wrapper for `pacman` and its various tools like `pacman-key`. pnx will default to _package manager mode_ in other words, and it will work as if you used `pacman` typically. For example, you can use it like this to install Bash.

`sudo pnx -S bash`

In this way, pnx will install Bash from the repositories (see [How to use it](https://github.com/Nitrux/pnx#how-to-use-it)).

pnx will not install the package to the host root directory; instead, it uses a separate directory as its root directory for installation located in `/home/.pnx`. To run a program installed using pnx, you can use it like this.

`pnx --launch kcalc`

In this way, pnx will act as a _'runtime'_ to launch the program using the libraries that the program needs from the pnx root directory but keeping the host settings, for example, Qt style, GTK theme, icon theme.

How to use it
========
To use pnx the host system should provide the following configuration files for Pacman and the repositories.

   - /etc/pacman.d/mirrorlist
   - /etc/pacman.conf
   - /usr/share/pacman/keyrings/{archlinux-revoked,archlinux-trusted,archlinux.gpg} or similar.

Do note that these files _wille be present in a system that already uses Pacman_ like Arch Linux, Manjaro, KaOS, Chakra, etc. 

Support for the AUR (or similar) repository
========
pnx does not have support for building packages from the Arch Linux User Repository.

Contribute
========
You are welcome to make pull requests to add features, fix bugs, improve stability, code readability, etc.

Known issues
=======
This is a list of known issues with pnx.

   - pnx does not support bulding AUR packages.
   - pnx does not resolve GNU C Library compatibility. If the program installed from Arch Linux was compiled against a newer Glibc version and the host does not have the same Glibc version, the program will not run.
   - pnx does not integrate the programs installed from Arch Linux to the host application menu.

# Issues
If you find problems with the contents of this repository please create an issue.

©2020 Nitrux Latinoamericana S.C.
