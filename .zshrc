# Base dir for my own settings
export ZSH_CONFIG=$HOME/.config/zsh
# Set up fzf
source $ZSH_CONFIG/fzf.zsh
# Aliases
source $ZSH_CONFIG/aliases.zsh
# Environment vars
source $ZSH_CONFIG/env.zsh
# Stuff copied from oh-my-zsh
source $ZSH_CONFIG/omz_completion.zsh
source $ZSH_CONFIG/omz_themes.zsh
source $ZSH_CONFIG/omz_git.zsh
source $ZSH_CONFIG/robbyrussell.zsh-theme

# Fix weird terminal bug 
# https://www.reddit.com/r/zsh/comments/2rfcba/sometimes_the_enter_key_prints_m_instead_of_doing/
ttyctl -f

# Vi mode
bindkey -v

# Infinite history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=999999999 # nine 9's = 1 billion
SAVEHIST=$HISTSIZE
# setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
# setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
# setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# # Adds visual cue that we're in NORMAL mode to the prompt
# # https://dougblack.io/words/zsh-vi-mode.html
# function zle-line-init zle-keymap-select {
#     VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
#     # TODO removed git_custom_status -- was it a custom function of the guy who posted this?
#     # RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $(git_custom_status) $EPS1"
#     RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#     zle reset-prompt
# }
# # Register function above with zle
# zle -N zle-line-init
# zle -N zle-keymap-select

# set up thefuck
# eval $(thefuck --alias)

# Fix for Tilix terminal
# https://gnunn1.github.io/tilix-web/manual/vteconfig/
if [ "$(uname)" = "Linux" ]; then
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
    fi
fi

# load z tool
# source ~/dotfiles/bin/z/z.sh

# pyenv setup (only on Linux)
if [ "$(uname)" = "Linux" ]; then
    export PATH="/home/csauer/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# git-fuzzy
export PATH="$HOME/builds/git-fuzzy/bin:$PATH"
