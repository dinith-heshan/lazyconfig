vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next match, centered' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous match, centered' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down, centered' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up, centered' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines, keep cursor' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left, keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right, keep selection' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' })

vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = '[W]rite file' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>', { desc = '[Q]uit window' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = '[B]uffer [D]elete' })

vim.keymap.set('t', '<C-q>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
