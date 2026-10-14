local function augroup(name)
  return vim.api.nvim_create_augroup('core-' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close-with-q'),
  pattern = { 'checkhealth', 'help', 'man' },
  desc = 'Close with q',
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = event.buf, silent = true, desc = 'Close window' })
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight-yank'),
  desc = 'Highlight on yank',
  callback = function()
    vim.hl.on_yank()
  end,
})

local function set_separator()
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#3b4261', bg = '#16161e' })
end

set_separator()

vim.api.nvim_create_autocmd('ColorScheme', {
  group = augroup('window-separator'),
  desc = 'Reapply window separator colors',
  callback = set_separator,
})
