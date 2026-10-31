# nvim keys

## Legend

### Modes

| Mode | Name | Active when |
|---|---|---|
| `n` | normal | moving around, running commands |
| `i` | insert | typing text |
| `v` | visual | selecting text (`v`, `V`, `C-v`) |
| `x` | visual only | like `v`, without select mode |
| `s` | select | replacing a selection by typing, e.g. snippet fields |
| `o` | operator-pending | after `d`, `y`, `c`…, waiting for a motion |
| `t` | terminal | typing inside `:terminal` |

### Notation

| Written | Means |
|---|---|
| `<leader>` | `Space` |
| `C-x` | `Ctrl-x` |
| `M-x` | `Alt-x` / `Option-x` |
| `S-Tab` | `Shift-Tab` |
| `CR` | `Enter` |

## Custom

Set in the config files.

### Search and scrolling

| Mode | Key | Does |
|---|---|---|
| `n` | `Esc` | clears the search highlight and the search text below the status line |
| `n` | `n` `N` | next / prev match, centered on screen |
| `n` | `C-d` `C-u` | half page down / up, centered on screen |

### Windows

| Mode | Key | Does |
|---|---|---|
| `n` | `C-h` `C-j` `C-k` `C-l` | moves to the window left / below / above / right, like tmux prefix `h` `j` `k` `l` |

### Editing

| Mode | Key | Does | Example |
|---|---|---|---|
| `n` | `J` | joins the next line onto this one, cursor stays put | |
| `v` | `<` `>` | indents left / right, selection stays | `>>>` indents three times |
| `v` | `J` `K` | moves the selected lines down / up, re-indenting | reorder a block |
| `n` `v` | `<leader>y` | yanks to the system clipboard, OSC 52 over SSH | `<leader>yy` yanks a line |

### Files and buffers

A buffer is an open file, a window is a view of one.

| Mode | Key | Does |
|---|---|---|
| `n` | `<leader>w` | writes the file |
| `n` | `<leader>q` | closes the window, exits on the last one |
| `n` | `<leader>bd` | deletes the buffer from the open-file list |
| `n` | `<leader>pv` | opens oil, the file explorer |
| `t` | `C-q` | leaves terminal typing to scroll and copy, instead of `C-\ C-n` |
| `n` | `q` | closes help, `:Man` and `:checkhealth` windows |

### Finding (telescope)

| Mode | Key | Does |
|---|---|---|
| `n` | `<leader><leader>` | lists open buffers |
| `n` | `<leader>ff` | finds files by name (`fd`) |
| `n` | `<leader>gf` | finds files tracked by git, skips ignored files |
| `n` | `<leader>lg` | searches file contents while typing (`ripgrep`) |
| `n` | `<leader>fw` | searches the project for the word under the cursor |

### Git

A hunk is a block of lines changed since the last commit, marked in the left column.

| Mode | Key | Does |
|---|---|---|
| `n` | `<leader>gs` | opens fugitive's git status window |
| `n` | `]h` `[h` | next / prev hunk |
| `n` | `<leader>hp` | previews the hunk, old lines next to new |
| `n` `v` | `<leader>hs` | stages the hunk, or only the selected lines |
| `n` `v` | `<leader>hr` | resets the hunk, discarding changes, `u` undoes |

### Code (LSP, formatting)

| Mode | Key | Does |
|---|---|---|
| `n` | `gd` | goes to the definition, `C-o` jumps back |
| `n` | `<leader>ld` | toggles LSP diagnostics for this buffer |
| `n` `v` | `<leader>cf` | formats the file or selection (ruff, prettier, stylua, shfmt, sqlfluff) |

### Surround (mini.surround)

Changes the pair around text: quotes, brackets, tags.

| Mode | Key | Does | Example |
|---|---|---|---|
| `n` `v` | `gsa` | adds: `gsa` + motion + char | `gsaiw"`: `word` → `"word"` |
| `n` | `gsd` | deletes: `gsd` + char | `gsd"`: `"word"` → `word` |
| `n` | `gsr` | replaces: `gsr` + old + new | `gsr"'`: `"word"` → `'word'` |
| `n` | `gsf` `gsF` | moves to the next / prev surrounding | `gsf)` |
| `n` | `gsh` | highlights a surrounding briefly | `gsh"` |
| `n` | `gsn` | sets how many lines to search, default 20 | |

### Auto pairs (mini.pairs)

| Mode | Key | Does | Example |
|---|---|---|---|
| `i` | `(` `[` `{` `"` `'` `` ` `` | inserts the closing char, cursor between | `(` → `(│)` |
| `i` | closing char | steps over an existing closing char | `)` at `(│)` → `()│` |

## Neovim built-in (0.12)

On by default, not set in the config.

### LSP

A language server (basedpyright, lua-language-server) understands the code. These keys ask it things.

| Mode | Key | Does |
|---|---|---|
| `n` | `K` | shows docs and type in a popup, `K` again to enter it |
| `n` | `grn` | renames the symbol everywhere it's used |
| `n` `x` | `gra` | code actions: quick fixes like "add import" |
| `n` | `grr` | lists references in the quickfix list |
| `n` | `gri` | goes to the implementation |
| `n` | `grt` | goes to the type definition, `user: User` → `class User` |
| `n` | `grx` | runs a codelens, e.g. "run test", where the server offers them |
| `n` | `gO` | lists functions, classes and variables in the file |
| `i` `s` | `C-s` | shows the function signature while typing a call |

### Diagnostics

| Mode | Key | Does |
|---|---|---|
| `n` | `]d` `[d` | next / prev error or warning |
| `n` | `]D` `[D` | last / first error or warning |
| `n` | `C-w d` | shows the full message under the cursor in a popup |

### Comments

| Mode | Key | Does | Example |
|---|---|---|---|
| `n` | `gcc` | toggles a comment on the line, style per language | `#` in Python, `--` in Lua |
| `n` | `gc` + motion | toggles comments on a range | `gcip` comments a paragraph |
| `x` | `gc` | toggles comments on the selection | |
| `o` | `gc` | a comment block as a text object | `dgc` deletes the block |

### Editing

| Mode | Key | Does | Example |
|---|---|---|---|
| `n` `x` | `gx` | opens the URL or path under the cursor | |
| `n` | `Y` | yanks to the end of the line, like `D` and `C` | |
| `n` | `&` | repeats the last `:s` on this line, same flags | |
| `x` | `*` `#` | searches forward / back for the selected text | |
| `x` | `@` | runs a macro on each selected line | `qa`…`q`, select, `@a` |
| `i` | `C-u` `C-w` | deletes the typed line / last word as its own undo step | |
| `n` | `]<Space>` `[<Space>` | adds an empty line below / above, cursor stays | |

### Windows

| Mode | Key | Does |
|---|---|---|
| `n` | `C-w s` `C-w v` | splits stacked / side by side, like tmux prefix `s` `v` |
| `n` | `C-l` | redraws and clears highlight, overridden by the custom window move |

### Lists

`]` is next, `[` is prev, capitals are last / first.

| Mode | Key | List | Filled by |
|---|---|---|---|
| `n` | `]q` `[q` `]Q` `[Q` | quickfix, one shared list | `grr`, telescope `C-q`, `:grep`, `:make` |
| `n` | `]l` `[l` `]L` `[L` | location list, one per window | `:lgrep`, some plugins |
| `n` | `]b` `[b` `]B` `[B` | buffers | open files |
| `n` | `]a` `[a` `]A` `[A` | argument list | `nvim a.py b.py` |
| `n` | `]t` `[t` `]T` `[T` | tags | tag files, rarely needed with LSP |

Example flow: `<leader>lg` to search, `C-q` to send results to quickfix, `]q` to step through them.

## blink.cmp (completion menu)

`default` preset, opens while typing.

### Keys

| Mode | Key | Does |
|---|---|---|
| `i` | `C-y` | accepts the item |
| `i` | `C-e` | closes the menu |
| `i` | `C-n` `C-p` / `Down` `Up` | next / prev item |
| `i` | `C-f` `C-b` | scrolls the docs popup down / up |
| `i` `s` | `Tab` `S-Tab` | jumps to the next / prev snippet field |
| `i` | `C-k` | toggles the signature popup |
| `i` | `C-Space` | opens the menu by hand, **disabled**: the tmux prefix |

## telescope (in a picker)

### Hidden files

`.gitignore` files inside a git repo and `.git` files stays hidden.

| Mode | Key | Does |
|---|---|---|
| `i` `n` | `C-a` | shows / hides dotfiles, keeps the typed text, stays on for the session |

### Moving

| Mode | Key | Does |
|---|---|---|
| `i` | `C-n` `C-p` / `Down` `Up` | next / prev result |
| `n` | `j` `k` | next / prev result |
| `n` | `H` `M` `L` | top / middle / bottom result |
| `i` `n` | `PageUp` `PageDown` | scrolls results |

### Opening

| Mode | Key | Does |
|---|---|---|
| `i` `n` | `CR` | opens in the current window |
| `i` `n` | `C-x` `C-v` `C-t` | opens in a stacked split / side split / tab |

### Preview

| Mode | Key | Does |
|---|---|---|
| `i` `n` | `C-u` `C-d` | scrolls up / down |
| `i` `n` | `C-f` `C-k` | scrolls left / right |

### Selecting

| Mode | Key | Does |
|---|---|---|
| `i` `n` | `Tab` `S-Tab` | marks / unmarks a result |
| `i` `n` | `C-q` | sends all results to quickfix |
| `i` `n` | `M-q` | sends marked results to quickfix |

### Other

| Mode | Key | Does |
|---|---|---|
| `i` | `C-r C-w` | inserts the word under the cursor into the prompt |
| `i` | `C-/` | lists the picker's keys |
| `n` | `?` | lists the picker's keys |
| `i` | `C-c` | closes |
| `n` | `Esc` | closes |

## oil (in an oil buffer)

A folder shown as text. Edits apply on `:w`: new lines create, changed lines rename, removed lines delete.

### Keys

| Mode | Key | Does |
|---|---|---|
| `n` | `CR` | opens the file or folder |
| `n` | `-` | goes to the parent folder |
| `n` | `_` | goes to nvim's working directory |
| `n` | `` ` `` / `g~` | sets the working directory / for this tab only |
| `n` | `C-s` | opens in a side split |
| `n` | `C-t` | opens in a tab |
| `n` | `C-p` | previews the file |
| `n` | `C-c` | closes oil |
| `n` | `gs` | changes the sort order |
| `n` | `gx` | opens with the system app |
| `n` | `g.` | shows / hides hidden files |
| `n` | `g\` | shows / hides the trash |
| `n` | `g?` | lists oil's keys |
| `n` | `C-h` | opens in a stacked split, **disabled**: window move |
| `n` | `C-l` | refreshes, **disabled**: window move |

## fugitive (in `:Git` status)

### Staging

| Key | Does |
|---|---|
| `s` / `u` / `-` | stages / unstages / toggles the file or hunk |
| `U` | unstages everything |
| `X` | discards the change |
| `I` `P` | stages / unstages interactively, piece by piece |

### Diffs

| Key | Does |
|---|---|
| `=` | shows / hides the diff inline |
| `>` `<` | shows / hides the inline diff |
| `dd` `dv` `ds` | opens a diff: split / side by side / stacked |
| `dp` | runs `git diff` on the file |
| `dq` | closes extra diff windows |

### Opening

| Key | Does |
|---|---|
| `CR` | opens the file |
| `o` `gO` `O` `p` | opens in a stacked split / side split / tab / preview |

### Moving

| Key | Does |
|---|---|
| `(` `)` | prev / next file or hunk |
| `[c` `]c` | prev / next hunk |
| `i` | next file or hunk, expanding its diff |
| `gu` `gU` `gs` | jumps to untracked / unstaged / staged |
| `gp` `gP` | jumps to unpushed / unpulled commits |

### Committing

| Key | Does |
|---|---|
| `cc` | commits |
| `ca` | amends, editing the message |
| `ce` | amends, keeping the message |
| `cw` | rewords the last commit |
| `cf` `cs` | makes a fixup / squash commit for the commit under the cursor |
| `crc` | reverts the commit under the cursor |
| `coo` | checks out the commit under the cursor |

### Stashing

| Key | Does |
|---|---|
| `czz` | stashes changes |
| `czp` / `czP` | pops the stash, keeping / not keeping the staged state |
| `cza` / `czA` | applies the stash, keeping / not keeping the staged state |

### Rebasing

| Key | Does |
|---|---|
| `ri` | starts an interactive rebase from the cursor |
| `ru` `rp` | rebases onto upstream / push target |
| `rr` `rs` `ra` `re` | continues / skips / aborts / edits the todo list |
| `rw` `rm` `rd` | rewords / edits / drops the commit under the cursor |

### Other

| Key | Does |
|---|---|
| `c<Space>` `cz<Space>` `r<Space>` | prefills `:Git commit` / `stash` / `rebase` |
| `.` | starts a `:` command with the file under the cursor |
| `gq` | closes the status window |
| `g?` | lists fugitive's keys |

## mason (in `:Mason`)

### Keys

| Key | Does |
|---|---|
| `i` | installs the package under the cursor |
| `u` / `U` | updates it / updates all |
| `c` / `C` | checks its version / checks all for updates |
| `X` | uninstalls it |
| `C-c` | cancels an install |
| `C-f` | filters by language |
| `CR` | expands package details / toggles the install log |
| `g?` | lists mason's keys |
