# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# csauer: shut up perl warnings
export LC_ALL=C

# Set default editor for git and other programs
export VISUAL=nvim
export EDITOR="$VISUAL"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Use 0.1 sec delay when pressing ESC to go to normal mode
export KEYTIMEOUT=1

# csauer: settings for doitclient
export DOIT_HOST=csauer
