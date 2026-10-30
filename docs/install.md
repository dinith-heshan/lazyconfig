# install

## Files

### Scripts

| File | Does |
|---|---|
| `install.sh` | picks the script for the OS |
| `install/macos.sh [--link-only]` | macOS steps |
| `install/linux.sh [--link-only]` | Linux steps |
| `install/common.sh` | shared: output, options, Homebrew, backup, linking |
| `Brewfile` | packages, casks on macOS only |

## macOS

### Steps

| Step | Full | `--link-only` |
|---|---|---|
| Command Line Tools | ✓ | |
| Homebrew | ✓ | |
| Packages | ✓ | |
| Dotfiles | `stow` | `ln -s` |

## Linux

### Steps

| Step | Desktop | Server | `--link-only` |
|---|---|---|---|
| System packages | ✓ | ✓ | |
| Homebrew | ✓ | ✓ | |
| Packages | ✓ | ✓ | |
| Font | ✓ | | |
| Dotfiles | `stow` | `stow` | `ln -s` |

### Detection

| Case | Detected by |
|---|---|
| desktop | `$DISPLAY` or `$WAYLAND_DISPLAY`, not over SSH |
| server | no display, text console, or SSH |
| link only | `--link-only` |
| root | refuses full install, `--link-only` works |

### Distros

| Distro | Package manager |
|---|---|
| Ubuntu, Debian, WSL2 | apt |
| Fedora, RHEL, Rocky, Alma, Amazon Linux | dnf |
| Arch, Manjaro | pacman |
| Other | `--link-only` |

## Not installed

### Left to the user

| What | How |
|---|---|
| zsh on Linux | distro package, command printed at the end |
| zsh as default | `chsh -s "$(command -v zsh)"`, printed at the end |
| Ghostty on Linux | [ghostty.org](https://ghostty.org/docs/install/binary), printed on desktop |

## Backup

### What happens to existing files

| Case | Result |
|---|---|
| file in the way | moved to `~/.lazyconfig-backup/<time>/` |
| link into another clone | link moved, the clone untouched |
| link into this clone | kept |
| files not in the repo | untouched |

## First nvim launch

### Installed by nvim

| What | Installed by |
|---|---|
| plugins | `vim.pack`, pinned in `nvim-pack-lock.json` |
| LSPs, formatters | mason |
| parsers | nvim-treesitter |

## Updating

### Commands

| Task | Command |
|---|---|
| pull and apply | `git pull && ./install.sh` |
| add a tool | add a line to `Brewfile`, run `./install.sh` |
| upgrade tools | `brew upgrade` |

## Troubleshooting

### Errors

| Message | Fix |
|---|---|
| `permission denied` on `./install.sh` | `chmod +x install.sh install/macos.sh install/linux.sh` |
| `Command Line Tools missing` | finish the install window, run again |
| `Homebrew won't run as root` | run as a normal user, or `--link-only` |
| `needs sudo` | `--link-only` |
| `no apt, dnf or pacman` | `--link-only` |
| `some packages failed` | fix the package shown above, run again |
