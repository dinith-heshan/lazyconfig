# ─────────────────────────────────────────────
#  History
# ─────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=100000                # commands kept in memory this session
SAVEHIST=100000                # commands written to disk on exit
setopt EXTENDED_HISTORY        # record timestamp and duration
setopt HIST_IGNORE_ALL_DUPS    # drop older duplicates
setopt HIST_IGNORE_SPACE       # skip commands starting with a space
setopt HIST_REDUCE_BLANKS      # strip redundant whitespace
setopt HIST_VERIFY             # confirm before running a !! expansion
setopt SHARE_HISTORY           # share across open tabs

# ─────────────────────────────────────────────
#  Colours
# ─────────────────────────────────────────────
export CLICOLOR=1              # colour macOS ls
export LS_COLORS='di=1;34:ln=1;35:so=1;32:pi=1;33:ex=1;31'

# ─────────────────────────────────────────────
#  Completion
# ─────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list ''                      # case-sensitive
zstyle ':completion:*' menu select                          # navigable menu
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # coloured menu
setopt COMPLETE_IN_WORD        # complete from cursor, not just end of word
setopt ALWAYS_TO_END           # move cursor to end after completing

# ─────────────────────────────────────────────
#  Vi mode
# ─────────────────────────────────────────────
bindkey -v
export KEYTIMEOUT=1            # 10ms Esc delay instead of 400ms
export EDITOR=nvim

# Cursor shape: block in normal, bar in insert
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

# ─────────────────────────────────────────────
#  Key bindings
# ─────────────────────────────────────────────
# k/j walk history, filtered by what's already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# ─────────────────────────────────────────────
#  Aliases & functions
# ─────────────────────────────────────────────
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

# lt [depth] [path]  — tree view, depth defaults to 2, path default to pwd
lt() {
  local level=2
  if [[ -n $1 && $1 =~ '^[0-9]+$' ]]; then
    level=$1
    shift
  fi
  eza --tree --level="$level" "$@"
}

# ─────────────────────────────────────────────
#  Prompt  (last — sets PROMPT)
# ─────────────────────────────────────────────
eval "$(starship init zsh)"
