# Setup fzf
# ---------
if [[ ! "$PATH" == */home/csauer/.vim/bundle/fzf/bin* ]]; then
  export PATH="$PATH:/home/csauer/.vim/bundle/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/csauer/.vim/bundle/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/csauer/.vim/bundle/fzf/shell/key-bindings.zsh"

