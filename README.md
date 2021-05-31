# The Ultimate Vim Setup
## By Josiah Tan


# Git cloning (for usage):

- Here it is assumed that you already have installed git
- cd ~
- git clone https://github.com/Josiah-tan/vimconfig.git .vim
- cd .vim
- git submodule update --init --recursive
- cd bundle/YouCompleteMe/
- ./install.py --clang-completer


# vim+python+jupyter integration
- pip3 install jupyter
- If the config files don't exist yet:
	- jupyter console --generate-config
	- jupyter qtconsole --generate-config



# Directory Layout

- pack:
	- Contains some configs for kite
- autoload:
	- Contains the pathogen.vim package required to manage all the plugins
- bundle:
	- Contains all the submodules (other repositories) required for the full vim experience
- info:
	- Contains all the info files to store all the registers for each .c file type
- view:
	- TODO

- templates:
	- solve.py - ultimate linear algebra solving script
	- markdown.py - for markdown and latex code
