# PNX [![Build Status](https://travis-ci.org/Nitrux/pnx.svg?branch=master)](https://travis-ci.org/Nitrux/pnx)

What is PNX
========
PNX (originally Pacman for Nitrux) allows users to install software from Linux distributions that use the Pacman package manager on other Linux distributions that don’t use it without interfering with the distributions default package manager. PNX by default utilizes the Arch Linux repositories, and it currently doesn’t have support for the AUR (or similar) repositories.

What PNX isn't
========

   - PNX is not a _new_ package manager.
   - PNX is not an Arch Linux container.
   - PNX is not an Arch Linux virtual machine.
   - PNX is not an Arch Linux installer.

How it works
========
PNX works by acting as a wrapper for `pacman` and its various tools like `pacman-key`. PNX will default to _package manager mode_ in other words, and it will work as if you used `pacman` typically. For example, you can use it like this to install Bash.

`sudo pnx -S bash`

In this way, PNX will install Bash from the Arch Linux repositories.

PNX will not install the package to the host root directory; instead, it uses its root directory for installation. To run a program installed using PNX, you can use it like this.

`pnx --launch kcalc`

In this way, PNX will act as a _'runtime'_ to launch the program using the libraries that the program needs from the PNX root directory but keeping the host settings, for example, the theming.

Contribute
========
You are welcome to make pull requests to improve PNX functionality.

# Issues
If you find problems with the contents of this repository please create an issue.

©2020 Nitrux Latinoamericana S.C.
