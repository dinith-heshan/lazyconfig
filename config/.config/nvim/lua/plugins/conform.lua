require('conform').setup({
  formatters_by_ft = {
    json = { 'prettier' },
    lua = { 'stylua' },
    markdown = { 'prettier' },
    python = { 'ruff_format' },
    sh = { 'shfmt' },
    sql = { 'sqlfluff' },
    yaml = { 'prettier' },
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = '[C]ode [F]ormat' })
