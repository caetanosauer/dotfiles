# Setup fzf
# ---------
if [[ ! "$PATH" == */home/csauer/.vim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/csauer/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/csauer/.vim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/csauer/.vim/plugged/fzf/shell/key-bindings.zsh"
