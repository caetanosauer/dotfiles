# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/csauer/.vim/bundle/fzf/bin* ]]; then
  export PATH="$PATH:/Users/csauer/.vim/bundle/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/csauer/.vim/bundle/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/csauer/.vim/bundle/fzf/shell/key-bindings.zsh"

