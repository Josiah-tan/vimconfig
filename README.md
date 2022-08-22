# The Ultimate Vim Setup
## By user Tan


# Git cloning (for usage):

- Here it is assumed that you already have installed git and vim
- cd ~
- git clone https://github.com/user-tan/vimconfig.git .vim
- vim ~/.vim/vimrc
- :PlugInstall



# vim+python+jupyter integration
- sudo pip3 install jupyter
	- note that sudo is important to make jupyter executable
- If the config files (~/.jupyter) don't exist yet:
	- jupyter console --generate-config
	- jupyter qtconsole --generate-config
		- if this doesn't work
			- pip3 install PySide2
- add this to jupyter_qtconsole_config.py
	- c.ConsoleWidget.include_other_output = True
	- c.JupyterWidget.syntax_style = "vim"




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
