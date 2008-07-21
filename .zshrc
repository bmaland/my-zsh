# Bjørn Arild Mæland's Zsh Configuration

# We define modern zsh as every version above 4.1.1
MODERN_ZSH=`echo "$ZSH_VERSION 4.1.1" | awk '{if ($1 > $2) print "t"; else print "f";}'`

# General configuration that applies to all platforms
source ~/.zsh/basic
source ~/.zsh/functions
source ~/.zsh/bindings
source ~/.zsh/aliases

# Load os specific settings
if [ ! -d /Users ]; then
  source ~/.zsh/linux

  # Try to figure out which distro we are on and load its config
  if [ -f /etc/popularity-contest.conf ]; then
    source ~/.zsh/ubuntu
  elif [ -f /etc/debian_version ]; then
    source ~/.zsh/debian
  elif [ -f /etc/arch-release ]; then
    source ~/.zsh/arch
  fi
else
  source ~/.zsh/osx
fi

# Load site specific file if it exists
if [ -f ~/.zsh/hosts/`hostname -s` ]; then
  source ~/.zsh/hosts/`hostname -s`
fi
