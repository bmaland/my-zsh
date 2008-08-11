# Bjørn Arild Mæland's Zsh Configuration

# We define modern zsh as every version above 4.1.1
MODERN_ZSH=`echo "$ZSH_VERSION 4.1.1" | awk '{if ($1 > $2) print "t"; else print "f";}'`

if [ -d /Users ]; then
  OS=osx
else
  OS=linux
fi

# General configuration that applies to all platforms
source ~/.zsh/basic
source ~/.zsh/functions
source ~/.zsh/bindings
source ~/.zsh/aliases

# Load os specific settings
if [[ $OS = linux ]]; then
  # Try to figure out which distro we are on
  if cat /etc/motd | grep -q Ubuntu; then
    DISTRO=ubuntu
  elif [[ -f /etc/debian_version ]]; then
    DISTRO=debian
  elif [[ -f /etc/arch-release ]]; then
    DISTRO=arch
  elif [[ -f /etc/redhat-release ]]; then
    DISTRO=redhat
  fi

  source ~/.zsh/linux
  if [ $DISTRO ]; then source ~/.zsh/$DISTRO; fi
else
  source ~/.zsh/osx
fi

# Load site specific file if it exists
if [ -f ~/.zsh/hosts/`hostname -s` ]; then
  source ~/.zsh/hosts/`hostname -s`
fi

# Hooks
preexec() {
  set-program-title $1
}

chpwd() {
  set-title `pwd`
}
set-title `pwd`
