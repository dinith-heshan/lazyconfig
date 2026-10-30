# shell

`.zshrc` `.zprofile` `.bashrc` `.inputrc`

| Setting | Value |
|---|---|
| mode | vi, `Esc` → block cursor, insert → bar |
| completion | case-sensitive, menu select |
| history | 100k, shared, no dups, space-prefixed ignored |
| `$EDITOR` | nvim |
| `KEYTIMEOUT` | 1 (instant `Esc`) |
| Homebrew | `.zprofile` expects `/opt/homebrew` |

| Shell | Mode | Key | Does |
|---|---|---|---|
| both | insert | `Esc` | normal mode |
| both | normal | `k` `j` | history filtered by what's typed |
| bash | insert | `Up` `Down` | history filtered by what's typed |
| bash | normal | `v` | disabled (no edit in `$EDITOR`) |

| Command | Does |
|---|---|
| `ls` | eza, dirs first |
| `ll` | eza long, hidden, git status |
| `lt [depth=2] [path]` | tree view |
| `nvim` | no args opens `.` |
| `grep` | colored |
