require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<C-space>'] = false,
  },
  sources = {
    default = { 'buffer', 'lsp', 'path', 'snippets' },
  },
  signature = { enabled = true },
})
