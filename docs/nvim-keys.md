# nvim keys

## Custom

Set in the config files.

| Mode | Key | Does |
|---|---|---|
| n | `Esc` | clear search highlight |
| n | `n` `N` | next / prev match, centered |
| n | `C-d` `C-u` | scroll, centered |
| n | `C-h` `C-j` `C-k` `C-l` | move window |
| n | `J` | join lines, keep cursor |
| v | `<` `>` | indent, keep selection |
| v | `J` `K` | move selection down / up |
| n v | `<leader>y` | yank to system clipboard |
| n | `<leader>w` | write |
| n | `<leader>q` | quit window |
| n | `<leader>bd` | delete buffer |
| t | `C-q` | exit terminal mode |
| n | `q` | close help / man / checkhealth |
| n | `<leader>pv` | oil |
| n | `<leader><leader>` | buffers |
| n | `<leader>ff` | find files |
| n | `<leader>fw` | grep word under cursor |
| n | `<leader>gf` | git files |
| n | `<leader>lg` | live grep |
| n | `<leader>gs` | fugitive status |
| n | `]h` `[h` | next / prev hunk |
| n | `<leader>hp` | preview hunk |
| n v | `<leader>hs` | stage hunk |
| n v | `<leader>hr` | reset hunk |
| n | `gd` | go to definition |
| n | `<leader>ld` | toggle diagnostics |
| n v | `<leader>cf` | format |
| n v | `gsa` | surround add |
| n | `gsd` | surround delete |
| n | `gsr` | surround replace |
| n | `gsf` `gsF` | surround find right / left |
| n | `gsh` | surround highlight |
| n | `gsn` | surround update search lines |
| i | `(` `[` `{` `"` `'` `` ` `` | auto-close pair (mini.pairs) |

## Neovim built-in (0.12)

On by default, not set in the config.

| Mode | Key | Does |
|---|---|---|
| n | `K` | LSP hover |
| n | `grn` | LSP rename |
| n x | `gra` | LSP code action |
| n | `grr` | LSP references |
| n | `gri` | LSP implementation |
| n | `grt` | LSP type definition |
| n | `grx` | LSP run codelens |
| n | `gO` | LSP document symbols |
| i s | `C-s` | LSP signature help |
| n | `]d` `[d` | next / prev diagnostic |
| n | `]D` `[D` | last / first diagnostic |
| n | `C-w d` | diagnostic float under cursor |
| n x | `gc` | toggle comment (motion / selection) |
| n | `gcc` | toggle comment line |
| o | `gc` | comment textobject |
| n x | `gx` | open link / file under cursor |
| n | `Y` | yank to end of line |
| n | `&` | repeat last `:s` with same flags |
| x | `*` `#` | search selection forward / back |
| x | `@` | run macro on each selected line |
| i | `C-u` `C-w` | delete with undo point |
| n | `]q` `[q` `]Q` `[Q` | quickfix next / prev / last / first |
| n | `]l` `[l` `]L` `[L` | loclist next / prev / last / first |
| n | `]b` `[b` `]B` `[B` | buffer next / prev / last / first |
| n | `]a` `[a` `]A` `[A` | arglist next / prev / last / first |
| n | `]t` `[t` `]T` `[T` | tag next / prev / last / first |
| n | `]<Space>` `[<Space>` | add blank line below / above |
| n | `C-l` | redraw + clear highlight (overridden by custom window move) |

## blink.cmp (`default` preset)

| Mode | Key | Does |
|---|---|---|
| i | `C-Space` | show menu / docs — **disabled in config** |
| i | `C-y` | accept |
| i | `C-e` | cancel |
| i | `C-n` `C-p` / `Down` `Up` | next / prev item |
| i | `C-f` `C-b` | scroll docs down / up |
| i | `Tab` `S-Tab` | snippet jump forward / back |
| i | `C-k` | toggle signature help |

## telescope (in a picker)

| Mode | Key | Does |
|---|---|---|
| i | `C-n` `C-p` / `Down` `Up` | next / prev result |
| n | `j` `k` | next / prev result |
| n | `H` `M` `L` | top / middle / bottom result |
| i n | `CR` | open |
| i n | `C-x` `C-v` `C-t` | open in split / vsplit / tab |
| i n | `C-u` `C-d` | scroll preview up / down |
| i n | `C-f` `C-k` | scroll preview left / right |
| i n | `PageUp` `PageDown` | scroll results |
| i n | `Tab` `S-Tab` | toggle multi-select |
| i n | `C-q` | all results to quickfix |
| i n | `M-q` | selected results to quickfix |
| i | `C-r C-w` | insert word under cursor |
| i | `C-/` | show picker keys |
| n | `?` | show picker keys |
| i | `C-c` | close |
| n | `Esc` | close |

## oil (in an oil buffer)

| Key | Does |
|---|---|
| `CR` | open |
| `-` | parent dir |
| `_` | cwd |
| `` ` `` / `g~` | `cd` / `tcd` to dir |
| `C-s` | open in vsplit |
| `C-h` | open in split — **disabled in config** |
| `C-t` | open in tab |
| `C-p` | preview |
| `C-l` | refresh — **disabled in config** |
| `C-c` | close |
| `gs` | change sort |
| `gx` | open externally |
| `g.` | toggle hidden |
| `g\` | toggle trash |
| `g?` | help |

Edit the buffer like text and `:w` to create / rename / delete.

## fugitive (in `:Git` status)

| Key | Does |
|---|---|
| `s` / `u` / `-` | stage / unstage / toggle |
| `U` | unstage all |
| `X` | discard change |
| `=` | toggle inline diff |
| `>` `<` | insert / remove inline diff |
| `I` `P` | patch add / reset |
| `dd` `dv` `ds` | diff split / vertical / horizontal |
| `dp` | `git diff` file |
| `dq` | close extra diff buffers |
| `CR` | open file |
| `o` `gO` `O` `p` | open in split / vsplit / tab / preview |
| `(` `)` | prev / next file or hunk |
| `[c` `]c` | prev / next hunk |
| `i` | next file or hunk, expanding |
| `gu` `gU` `gs` | jump to untracked / unstaged / staged |
| `gp` `gP` | jump to unpushed / unpulled |
| `cc` | commit |
| `ca` | amend, edit message |
| `ce` | amend, keep message |
| `cw` | reword last commit |
| `cf` `cs` | fixup / squash commit for cursor |
| `crc` | revert commit under cursor |
| `coo` | checkout commit under cursor |
| `czz` | stash push |
| `czp` / `czP` | stash pop (keep index / plain) |
| `cza` / `czA` | stash apply (keep index / plain) |
| `ri` | interactive rebase from cursor |
| `ru` `rp` | rebase onto upstream / push |
| `rr` `rs` `ra` `re` | rebase continue / skip / abort / edit todo |
| `rw` `rm` `rd` | reword / edit / drop commit under cursor |
| `c<Space>` `cz<Space>` `r<Space>` | prefill `:Git commit` / `stash` / `rebase` |
| `.` | `:` with file under cursor |
| `gq` | close |
| `g?` | help |

## mason (in `:Mason`)

| Key | Does |
|---|---|
| `i` | install |
| `u` / `U` | update / update all |
| `c` / `C` | check version / check outdated |
| `X` | uninstall |
| `C-c` | cancel install |
| `C-f` | filter by language |
| `CR` | expand package / toggle log |
| `g?` | help |
