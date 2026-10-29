# lazyconfig

## Package manager

| Tool | Used for |
|---|---|
| [Homebrew](https://brew.sh) | installs and updates all tools below, macOS and Linux |

## Tools

| Tool | Used for |
|---|---|
| [GNU Stow](https://www.gnu.org/software/stow/) | symlinking into `~` |
| [Ghostty](https://github.com/ghostty-org/ghostty) | terminal |
| [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts) | font, icons |
| [tmux](https://github.com/tmux/tmux) | multiplexer |
| [starship](https://github.com/starship/starship) | prompt |
| [eza](https://github.com/eza-community/eza) | `ls` `ll` `lt` |
| [neovim](https://github.com/neovim/neovim) | editor, 0.12+ for `vim.pack` |
| [Node.js](https://github.com/nodejs/node) | mason installs prettier, basedpyright via npm |
| [Python 3](https://github.com/python/cpython) | mason installs ruff, sqlfluff via pip |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | telescope grep |
| [fd](https://github.com/sharkdp/fd) | telescope find files |
| [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter) | building parsers |
| `make` + C compiler | building telescope-fzf-native |

## Prefixes

| Where | Prefix |
|---|---|
| tmux | `C-Space` |
| tmux over SSH | `C-b` |
| nvim leader | `Space` |

## shell

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

## tmux

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

## ghostty

`.config/ghostty/config.ghostty`

| Setting | Value |
|---|---|
| theme | TokyoNight Night |
| font | JetBrainsMono Nerd Font, 14 |
| option key | acts as alt |
| shell integration | sudo, ssh-terminfo, ssh-env |
| new tab / split | inherits cwd |

## starship

`.config/starship.toml`

| Setting | Value |
|---|---|
| prompt | `❯`, green ok / red error |
| directory | full path, truncated to repo root |

## git

| File | Holds |
|---|---|
| `.gitconfig` | name, email |
| `~/.gitconfig.local` | machine-specific settings, not in repo |

## nvim

`.config/nvim`. Plugins install via `vim.pack` on first launch, pinned in `nvim-pack-lock.json`.

| Setting | Value |
|---|---|
| indent | 2 spaces |
| numbers | relative |
| mouse | off |
| wrap | off |
| swap / undo | no swapfile, persistent undo |
| search | smartcase |
| netrw | disabled, oil replaces it |

### Plugins

| Plugin | Used for |
|---|---|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | colorscheme, transparent |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | statusline |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | icons |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | file explorer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | fuzzy finder |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | telescope dependency |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | fzf sorter |
| [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) | `vim.ui.select` in telescope |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (`main`) | highlighting, indent |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim) | pairs, surround |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | git hunks |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | git |
| [blink.cmp](https://github.com/saghen/blink.cmp) | completion |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configs |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP / formatter installer |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | auto-enable mason LSPs |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | auto-install LSPs / formatters |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | formatting |

### Keybindings

Custom, from the config files.


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
| n | `<leader>sh` `<leader>sv` | split / vsplit |
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

### Neovim built-in (0.12)

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

### blink.cmp (`default` preset)

| Mode | Key | Does |
|---|---|---|
| i | `C-Space` | show menu / docs — **disabled in config** |
| i | `C-y` | accept |
| i | `C-e` | cancel |
| i | `C-n` `C-p` / `Down` `Up` | next / prev item |
| i | `C-f` `C-b` | scroll docs down / up |
| i | `Tab` `S-Tab` | snippet jump forward / back |
| i | `C-k` | toggle signature help |

### telescope (in a picker)

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

### oil (in an oil buffer)

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

### fugitive (in `:Git` status)

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

### mason (in `:Mason`)

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
