# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias vimdiff="nvim -d"

# Alias for sending current X clipboard to windows via doitclient
alias wcopy="xclip -o | doitclient wclip"
# ... and the other way around (paste from windows)
alias wpaste="doitclient wclip -r | xclip -i"

# fd, a `find` alternative
# Linux uses "fdfind" by default, mac just "fd"; my fzf calls "fdfind"
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     alias fd="fdfind";;
    Darwin*)    alias fdfind="fd";;
esac

# watson time tracker (my own wrapper)
alias w="watson_wrapper"

# buku bookmark manager
alias b="buku --suggest"

# quiet mode in gdb (removes copyright msg)
alias gdb="gdb -q"

# tree command preserving colors with less as pager
alias treel="tree -C | less -R"

alias g="git"

# exa and ls
if command -v exa &> /dev/null; then
    alias ll='exa -lahF --git'
    alias lt='exa --tree --level=2'
else
    alias ll='ls -lh'
fi

# ccmake does not work with 256 colors for some reason
alias ccmake='TERM="screen-16color" ccmake'
