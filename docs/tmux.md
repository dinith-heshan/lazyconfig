# tmux

`.tmux.conf`

| Setting | Value |
|---|---|
| mouse | on |
| windows | start at 1, renumber on close |
| splits / new window | keep current path |
| copy mode | vi |
| colors | tokyonight, ghostty RGB |

| Table | Key | Does |
|---|---|---|
| — | `C-b` | unbound locally (default prefix), prefix again over SSH |
| prefix | `h` `j` `k` `l` | move pane |
| prefix | `s` | split down |
| prefix | `v` | split right |
| prefix | `c` | new window |
| prefix | `Esc` | copy mode |
| prefix | `r` | reload config |
| copy-mode | `v` | start selection |
| copy-mode | `V` | select line |
| copy-mode | `C-v` | block selection |
| copy-mode | `y` | copy and exit |
