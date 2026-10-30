# install

`install.sh` `install/` `Brewfile`

## Files

| File | Does |
|---|---|
| `install.sh` | picks the script for the OS |
| `install/macos.sh` | macOS steps |
| `install/linux.sh` | Linux steps, `--link-only` |
| `install/common.sh` | shared: output, Homebrew, backup, stow |
| `Brewfile` | packages, casks on macOS only |

## macOS

```sh
xcode-select --install
git clone https://github.com/dinith-heshan/lazyconfig.git ~/lazyconfig
cd ~/lazyconfig && ./install.sh
```

| Step | Does |
|---|---|
| Command Line Tools | git, make, C compiler; stops if missing |
| Homebrew | installed if missing, asks for password once |
| Packages | `brew bundle`, skipped if all installed |
| Dotfiles | backup, then `stow` |

## Linux

```sh
git clone https://github.com/dinith-heshan/lazyconfig.git ~/lazyconfig
cd ~/lazyconfig && ./install.sh              # desktop, server
cd ~/lazyconfig && ./install.sh --link-only  # root, no sudo, containers
```

| Step | Desktop | Server | `--link-only` |
|---|---|---|---|
| System packages | ✓ | ✓ | |
| Homebrew | ✓ | ✓ | |
| Packages | ✓ | ✓ | |
| Font | ✓ | | |
| Stow | | | from distro if root |
| Dotfiles | ✓ | ✓ | ✓ |

| Case | Detected by |
|---|---|
| desktop | `$DISPLAY` or `$WAYLAND_DISPLAY`, not over SSH |
| server | no display |
| link only | `--link-only` |

| Distro | Package manager |
|---|---|
| Ubuntu, Debian, WSL2 | apt |
| Fedora, RHEL, Rocky, Alma, Amazon Linux | dnf |
| Arch, Manjaro | pacman |
| Alpine, others | `--link-only` |

## Not installed

| What | How |
|---|---|
| zsh as default | `chsh -s "$(command -v zsh)"`, printed at the end |
| zsh on Linux | distro package, printed at the end |
| Ghostty on Linux | [ghostty.org](https://ghostty.org/docs/install/binary), printed on desktop |

## Backup

| Case | Result |
|---|---|
| file in the way | moved to `~/.lazyconfig-backup/<time>/` |
| link into another clone | link moved, the clone untouched |
| link into this clone | kept |
| files not in the repo | untouched |

## First nvim launch

| What | Installed by |
|---|---|
| plugins | `vim.pack`, pinned in `nvim-pack-lock.json` |
| LSPs, formatters | mason |
| parsers | nvim-treesitter |

## Updating

| Task | Command |
|---|---|
| pull and apply | `git pull && ./install.sh` |
| add a tool | add a line to `Brewfile`, run `./install.sh` |
| upgrade tools | `brew upgrade` |
