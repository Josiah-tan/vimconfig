# The Ultimate Vim Setup
## By Josiah Tan


# Git cloning (for usage):

- Here it is assumed that you already have installed git and vim
- cd ~
- git clone https://github.com/Josiah-tan/vimconfig.git .vim
- vim ~/.vim/vimrc
- :PlugInstall



# vim+python+jupyter integration
- pip3 install jupyter
- If the config files don't exist yet:
	- jupyter console --generate-config
	- jupyter qtconsole --generate-config



# Directory Layout

- pack:
	- Contains some configs for kite
- autoload:
	- Contains the plug.vim package required to manage all the plugins
- plugged:
	- Contains plugins
- view:
	- TODO
- templates:
	- solve.py - ultimate linear algebra solving script
	- markdown.py - for markdown and latex code
- plugin:
	- contains configurations that have been split apart from the vimrc 
		- this makes the code alot easier to read
			- not clumped up in one file
		- also makes maintaining the code alot easier
- lua:
	- contains configurations that are specifically written in lua
		- telescope:
			- customised fuzzy finding code
