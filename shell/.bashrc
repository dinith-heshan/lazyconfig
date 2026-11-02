for brew_bin in \
  /opt/homebrew/bin/brew \
  /usr/local/bin/brew \
  /home/linuxbrew/.linuxbrew/bin/brew \
  "$HOME/.linuxbrew/bin/brew"; do
  if [ -x "$brew_bin" ]; then
    eval "$("$brew_bin" shellenv bash)"
    break
  fi
done
unset brew_bin

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

if [ -r "$HOME/.config/fzf/config" ]; then
  export FZF_DEFAULT_OPTS_FILE="$HOME/.config/fzf/config"
fi
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
fi
if command -v eza >/dev/null 2>&1; then
  export FZF_ALT_C_OPTS="--preview 'eza --tree --level=1 --color=always {}'"
fi
command -v fzf >/dev/null 2>&1 && eval "$(fzf --bash 2>/dev/null)"

if command -v eza >/dev/null 2>&1; then
  alias ll='eza -agHhilM --git --group-directories-first'
  alias ls='eza --group-directories-first'
else
  alias ll='ls -lAh'
fi
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

command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"
