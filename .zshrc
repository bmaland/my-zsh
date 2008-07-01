# Loads up teh files

source ~/.zsh/basic
source ~/.zsh/bindings
source ~/.zsh/aliases
source ~/.zsh/functions

# Load os specific settings
if [ -f /etc/debian_version ]; then
	source ~/.zsh/debian
elif [ -f /etc/arch-release ]; then
	source ~/.zsh/arch
else
	source ~/.zsh/osx
fi

# Load site specific file if it exists
if [ -f ~/.zsh/`hostname` ]; then
	source ~/.zsh/`hostname`
fi

