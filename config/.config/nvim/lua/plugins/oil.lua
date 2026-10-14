require('oil').setup({
  default_file_explorer = true,
  view_options = { show_hidden = true },
  columns = { 'icon' },
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
  },
})

vim.keymap.set('n', '<leader>pv', '<cmd>Oil<CR>', { desc = '[P]roject [V]iew' })
