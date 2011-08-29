# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#
#

PROMPT='
%{$fg[green]%}%n%{$reset_color%} at %{$fg[blue]%}$(hostname -s)%{$reset_color%} in %{$fg[cyan]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) 
$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
RPROMPT='${return_status}%{$reset_color%}'

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

tegakiroot=$HOME/Desktop/projects/hwr

if [ -e $tegakiroot ] ; then
    export PYTHONPATH=$tegakiroot/tegaki-python:$tegakiroot/tegaki-pygtk
fi

projectroot=$HOME/Desktop/projects

if [ -e $projectroot/scikit-learn ] ; then
    export PYTHONPATH=$projectroot/scikit-learn:$PYTHONPATH
fi

if [ -e $projectroot/caraml ] ; then
    export PYTHONPATH=$projectroot/caraml:$PYTHONPATH
fi

alias sshnobel='ssh -t nobel screen -D -R -S work'
