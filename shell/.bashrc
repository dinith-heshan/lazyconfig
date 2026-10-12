# ─────────────────────────────────────────────
#  History
# ─────────────────────────────────────────────
HISTFILE=~/.bash_history
HISTSIZE=100000                # commands kept in memory this session
HISTFILESIZE=100000            # commands written to disk
HISTCONTROL=ignoreboth:erasedups   # ignore dups + leading-space commands
HISTTIMEFORMAT='%F %T '        # timestamps
shopt -s histappend            # append, don't overwrite
shopt -s cmdhist               # multi-line commands as one entry
shopt -s checkwinsize
PROMPT_COMMAND='history -a'    # write after each command (shared across tabs)

# ─────────────────────────────────────────────
#  Colours
# ─────────────────────────────────────────────
export LS_COLORS='di=1;34:ln=1;35:so=1;32:pi=1;33:ex=1;31'

# ─────────────────────────────────────────────
#  Completion
# ─────────────────────────────────────────────
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# ─────────────────────────────────────────────
#  Vi mode      (cursor shapes live in .inputrc)
# ─────────────────────────────────────────────
export EDITOR=nvim

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
#  Prompt  (last — sets PS1)
# ─────────────────────────────────────────────
eval "$(starship init bash)"
