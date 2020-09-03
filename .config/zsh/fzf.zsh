# FZF configuration
export FZF_BASE=~/.vim/plugged/fzf
export DISABLE_FZF_KEY_BINDINGS="false"

# Instead of doing this...
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# ... I'm copy-pasting the contents of that file:
# Adjust path with vim-installed fzf
if [[ ! "$PATH" == *$FZF_BASE/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$FZF_BASE/bin"
fi
# Auto-completion
[[ $- == *i* ]] && source "$FZF_BASE/shell/completion.zsh" 2> /dev/null
# Key bindings
source "$FZF_BASE/shell/key-bindings.zsh"

# Make fzf use fd instead of find: it is faster and also respects .gitignore
# Note that fd is an alias to fdfind
if [ "$(uname)" = "Darwin" ]; then
    export FZF_DEFAULT_COMMAND='fd --type f'
else
    export FZF_DEFAULT_COMMAND='fdfind --type f'
fi

