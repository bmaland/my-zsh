# Bjørn Arild Mæland's Zsh Configuration

# We define modern zsh as every version above 4.1.1, and ancient zsh as pre 3.0.9
MODERN_ZSH=`echo "$ZSH_VERSION 4.1.1" | awk '{if ($1 > $2) print "t"; else print "f";}'`
ANCIENT_ZSH=`echo "$ZSH_VERSION 3.0.9" | awk '{if ($1 < $2) print "t"; else print "f";}'`

if [ -d /Users ]; then
  OS=osx
elif uname -a | grep SunOS > /dev/null; then
  OS=solaris
else
  OS=linux
fi

# General configuration that applies to all platforms
source ~/.zsh/basic
source ~/.zsh/functions
source ~/.zsh/bindings
source ~/.zsh/aliases

# This is required to make Tramp work
[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '

# Load os specific settings
if [[ $OS = linux ]]; then
  # Try to figure out which distro we are on
  if [[ -f /etc/lsb-release ]]; then
    if cat /etc/lsb-release | grep -q Ubuntu; then
      DISTRO=ubuntu
    fi
  elif [[ -f /etc/debian_version ]]; then
    DISTRO=debian
  elif [[ -f /etc/arch-release ]]; then
    DISTRO=arch
  elif [[ -f /etc/redhat-release ]]; then
    DISTRO=redhat
  fi

  source ~/.zsh/linux
  if [ $DISTRO ]; then source ~/.zsh/$DISTRO; fi
elif [[ $OS = osx ]]; then
  source ~/.zsh/osx
elif [[ $OS = solaris ]]; then
  source ~/.zsh/solaris
fi

# Load site specific file if it exists
# NOTE this is a workaround, hostname on Solaris 9 does not support the -s option
if [ -f ~/.zsh/hosts/$HOST ]; then
  source ~/.zsh/hosts/$HOST
elif [ -f ~/.zsh/hosts/`hostname -s` ]; then
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

if [ -f ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
