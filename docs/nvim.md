# nvim

`.config/nvim`. Plugins install via `vim.pack` on first launch, pinned in `nvim-pack-lock.json`.

## Settings

| Setting | Value |
|---|---|
| indent | 2 spaces |
| numbers | relative |
| mouse | off |
| wrap | off |
| swap / undo | no swapfile, persistent undo |
| clipboard | system tool locally, OSC 52 over SSH |
| search | smartcase |
| netrw | disabled, oil replaces it |

## Plugins

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

Keys: [nvim-keys.md](nvim-keys.md)
