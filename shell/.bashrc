eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

HISTFILE=~/.bash_history
HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '
shopt -s histappend
shopt -s cmdhist
shopt -s checkwinsize
PROMPT_COMMAND='history -a'

export LS_COLORS='di=1;34:ln=1;35:so=1;32:pi=1;33:ex=1;31'
export EDITOR=nvim

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

alias ll='eza -agHhilM --git --group-directories-first'
alias ls='eza --group-directories-first'
alias grep='grep --color=auto'

nvim() {
  if [ $# -eq 0 ] && [ -t 0 ]; then
    command nvim .
  else
    command nvim "$@"
  fi
}

lt() {
  local level=2 re='^[0-9]+$'
  if [[ -n $1 && $1 =~ $re ]]; then
    level=$1
    shift
  fi
  eza --tree --level="$level" "$@"
}

eval "$(starship init bash)"
