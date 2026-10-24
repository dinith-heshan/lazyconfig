require('mason').setup()

require('mason-tool-installer').setup({
  ensure_installed = {
    'basedpyright',
    'lua-language-server',
    'prettier',
    'ruff',
    'shfmt',
    'sqlfluff',
    'stylua',
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    },
  },
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = { source = 'if_many' },
})

require('mason-lspconfig').setup({ automatic_enable = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('plugins-lsp-attach', { clear = true }),
  desc = 'Buffer-local LSP keymaps',
  callback = function(args)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = 'Go to [D]efinition' })
  end,
})

vim.keymap.set('n', '<leader>ld', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, { desc = '[L]SP [D]iagnostics' })
