# Loads up teh files

source ~/.zsh/basic
source ~/.zsh/functions
source ~/.zsh/bindings
source ~/.zsh/aliases

# Load os specific settings
if [ -f /etc/debian_version ]; then
	source ~/.zsh/debian
elif [ -f /etc/arch-release ]; then
	source ~/.zsh/arch
else
	source ~/.zsh/osx
fi

# Load site specific file if it exists
if [ -f ~/.zsh/`hostname -s` ]; then
	source ~/.zsh/`hostname -s`
fi

