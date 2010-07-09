# never delete files without asking
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm --interactive'

# aliases 
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias df='df --human-readable'
alias du='du --human-readable'

# never beep
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

# Ctrl+D equivalent to logout
unsetopt ignore_eof

# confirm before rm *
unsetopt rm_star_silent

# no speel checking
setopt nullglob

setopt auto_remove_slash
#unsetopt glob_dots
setopt chase_links

setopt hist_verify
# "directoryname" equivalent to "cd directoryname"
setopt auto_cd

setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home

unsetopt bg_nice
unsetopt hup

# completion

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

autoload -U compinit
compinit

# colors
alias ls='ls --classify --tabsize=0 --literal --color=auto --show-control-chars --human-readable'
alias grep='grep --color=auto'


#eval `dircolors ~/.dir_colors`

autoload colors
colors
