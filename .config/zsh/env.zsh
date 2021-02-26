# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/opt/bin:/usr/local/opt/gnu-sed/libexec/gnubin:/opt/cmake/bin:/usr/local/opt/bison/bin:/usr/local/bin:$PATH

# csauer: shut up perl warnings
# export LC_ALL=C

# Set default editor for git and other programs
export VISUAL=nvim
export EDITOR="$VISUAL"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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

# skip venv generation in Hyper
export HYPER_VENV_DISABLE=1

# Use icecc with ccache in Hyper -- only Linux
if [[ "$(uname)" == "Linux" ]]; then
    export CCACHE_PREFIX="$HOME/bin/icecc-strip.sh"
fi
