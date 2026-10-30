# clipboard

Copies go to the local clipboard via OSC 52, through tmux and ssh.

## Files

| File | Setting |
|---|---|
| `config.ghostty` | `clipboard-write = allow`, `copy-on-select = clipboard` |
| `.tmux.conf` | `set-clipboard on`, `terminal-features` clipboard |
| `lua/core/clipboard.lua` | OSC 52 over SSH |

## Copy paths

| Where | Shell text | nvim `<leader>y` |
|---|---|---|
| local | ghostty select | pbcopy / wl-copy / xclip |
| local tmux | tmux select, copy mode `y` | pbcopy / wl-copy / xclip |
| ssh | ghostty select | OSC 52 |
| ssh, remote tmux | remote tmux select, copy mode `y` | OSC 52 |
| local tmux, ssh | local tmux select | OSC 52 |
| local tmux, ssh, remote tmux | remote tmux select, copy mode `y` | OSC 52 |

## Notes

| Case | Behavior |
|---|---|
| remote machine | needs this repo stowed |
| `Shift` + drag | ghostty select inside tmux / nvim |
| paste from local | `Cmd+V` / `Ctrl+Shift+V` |
| `"+p` over SSH | nvim's last yank |
| nvim mouse select | visual mode |
