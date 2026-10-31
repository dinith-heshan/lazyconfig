# tmux

`.tmux.conf`

## Settings

| Setting | Value |
|---|---|
| mouse | on |
| windows | start at 1, renumber on close |
| splits / new window | keep current path |
| copy mode | vi |
| clipboard | OSC 52, [clipboard](clipboard.md) |
| colors | tokyonight, ghostty RGB |
| status right | `hostname [session]`, hostname over SSH, orange while the prefix is active |

## Keys

| Table | Key | Does |
|---|---|---|
| — | `C-Space` | local prefix |
| — | `C-b` | remote prefix |
| prefix | `C-b` | send prefix to nested remote |
| prefix | `h` `j` `k` `l` | move pane |
| prefix | `s` | split stacked |
| prefix | `v` | split vertically |
| prefix | `c` | new window |
| prefix | `r` | reload config |
| prefix | `q` | copy mode |
| copy-mode | `v` | start selection |
| copy-mode | `V` | select line |
| copy-mode | `C-v` | block selection |
| copy-mode | `y` | copy and exit |
| copy-mode | `q` | exit copy mode |
