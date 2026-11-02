# fzf

`.config/fzf/config`, exports in `.zshrc` `.bashrc`

## Settings

| Setting | Value |
|---|---|
| layout | prompt on top, 40% of the screen |
| colors | tokyonight, terminal background |
| files (`C-t`, `fzf`) | `fd`: dotfiles included, `.git` skipped, `.gitignore`d skipped in git repos |
| directories (`M-c`) | `fd`, preview with `eza --tree` |
| without `fd` / `eza` | fzf's own walker, no preview (ex: `--link-only` setups) |

## Completion 

`COMMAND [DIRECTORY/][FUZZY_PATTERN]**<TAB>`

The command decides what is listed.

| Command | Lists |
|---|---|
| any, e.g. `nvim` `cat` `cp` | files and directories |
| `cd` `pushd` `rmdir` | directories |
| `ssh` `telnet` | hosts from `~/.ssh/config` and `known_hosts` |
| `export` `unset` | environment variables |
| `unalias` | aliases |
| `kill` | processes |
