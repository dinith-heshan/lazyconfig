# lazyconfig

Terminal configuration for macOS and Linux.

## Fork

The install scripts have no user-specific paths. Only these files need changes in a fork.

| File | Change |
|---|---|
| `README.md` | `dinith-heshan` in the clone commands to the fork's owner |
| `gitconfig/.gitconfig` | `name` and `email` |

## Install

### macOS

```sh
xcode-select --install
git clone https://github.com/dinith-heshan/lazyconfig.git ~/lazyconfig
cd ~/lazyconfig && ./install.sh
```

### Linux

```sh
git clone https://github.com/dinith-heshan/lazyconfig.git ~/lazyconfig
cd ~/lazyconfig && ./install.sh
```

### Access
 
| Machine | Needs |
|---|---|
| macOS | admin password, asked once for Homebrew |
| Linux | sudo, for system packages and Homebrew |
| no sudo or admin rights | `./install.sh --link-only` |

### Options

| Option | Does |
|---|---|
| `--link-only` | Links configs with `ln -s`, installs nothing. For machines without sudo or admin rights |

## Package manager

| Tool | Used for |
|---|---|
| [Homebrew](https://brew.sh) | install and update tools on macOS and Linux, listed in `Brewfile` |

## Tools

| Tool | Used for | Installed by |
|---|---|---|
| [GNU Stow](https://www.gnu.org/software/stow/) | symlinking into `~` | Brewfile |
| [Ghostty](https://github.com/ghostty-org/ghostty) | terminal | Brewfile on macOS, manual on Linux |
| [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts) | font, icons | Brewfile on macOS, `install.sh` on Linux desktop |
| [tmux](https://github.com/tmux/tmux) | multiplexer | Brewfile |
| [starship](https://github.com/starship/starship) | prompt | Brewfile |
| [eza](https://github.com/eza-community/eza) | `ls` `ll` `lt` | Brewfile |
| [neovim](https://github.com/neovim/neovim) | editor, 0.12+ for `vim.pack` | Brewfile |
| [Node.js](https://github.com/nodejs/node) | mason installs prettier, basedpyright via npm | Brewfile |
| [Python 3](https://github.com/python/cpython) | mason installs ruff, sqlfluff via pip | Brewfile |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | telescope grep | Brewfile |
| [fd](https://github.com/sharkdp/fd) | telescope find files | Brewfile |
| [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter) | building parsers | Brewfile |
| `make` + C compiler | building telescope-fzf-native | Command Line Tools on macOS, distro on Linux |

## Prefixes

| Where | Prefix |
|---|---|
| tmux | `C-Space` |
| tmux over SSH | `C-b` |
| nvim leader | `Space` |

## Docs

| File | Covers |
|---|---|
| [install](docs/install.md) | steps, detection, backup, troubleshooting |
| [shell](docs/shell.md) | zsh, bash, readline, aliases |
| [tmux](docs/tmux.md) | settings, keys |
| [ghostty](docs/ghostty.md) | terminal settings |
| [starship](docs/starship.md) | prompt |
| [git](docs/git.md) | gitconfig |
| [nvim](docs/nvim.md) | settings, plugins |
| [nvim keys](docs/nvim-keys.md) | custom, built-in and plugin keys |
| [clipboard](docs/clipboard.md) | copying to the local clipboard from tmux, nvim, SSH |
