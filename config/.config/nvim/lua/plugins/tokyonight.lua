require('tokyonight').setup {
  transparent = true,
  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    sidebars = 'transparent',
    floats = 'transparent',
  },
}

vim.cmd.colorscheme 'tokyonight-night'
