#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

plugins=(git zsh-syntax-highlighting)


 export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/3.5/bin:/Users/deepansaravanan/.nvm/versions/node/v5.0.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Applications/GAMS24.8/GAMS Terminal.app/../sysdir:/usr/local/bin/emacs-26.1"

# Customize to your needs...
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel 
source /usr/local/bin/virtualenvwrapper.sh
export DEFAULT_USER=deepansaravanan@Deepans-MacBook-Pro


scpfunction() {
    scp $1 deepans@eniac.seas.upenn.edu:
}

alias eniacscp=scpfunction

alias sublime='open -a "Sublime Text"' $1

alias pycharm='/usr/local/bin/charm' $1

alias intellij='/usr/local/bin/idea' $1

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ORDER=(user host dir git node pyenv exec_time line_sep jobs exit_code char)

