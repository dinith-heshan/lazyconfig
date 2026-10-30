HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY

export CLICOLOR=1
export LS_COLORS='di=1;34:ln=1;35:so=1;32:pi=1;33:ex=1;31'
export EDITOR=nvim
export KEYTIMEOUT=1

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list ''
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

bindkey -v

function zle-keymap-select {
  case $KEYMAP in
    vicmd)      printf '\e[2 q' ;;
    viins|main) printf '\e[6 q' ;;
  esac
}
zle -N zle-keymap-select

function zle-line-init {
  zle -K viins
  printf '\e[6 q'
}
zle -N zle-line-init

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

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
  local level=2
  if [[ -n $1 && $1 =~ '^[0-9]+$' ]]; then
    level=$1
    shift
  fi
  eza --tree --level="$level" "$@"
}

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
