local gitsigns = require('gitsigns')

gitsigns.setup({
  on_attach = function(buffer_number)
    vim.keymap.set('n', ']h', function()
      gitsigns.nav_hunk('next')
    end, { buffer = buffer_number, desc = 'Next [H]unk' })
    vim.keymap.set('n', '[h', function()
      gitsigns.nav_hunk('prev')
    end, { buffer = buffer_number, desc = 'Previous [H]unk' })

    vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { buffer = buffer_number, desc = '[H]unk [P]review' })
    vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { buffer = buffer_number, desc = '[H]unk [S]tage' })
    vim.keymap.set('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { buffer = buffer_number, desc = '[H]unk [S]tage selection' })
    vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { buffer = buffer_number, desc = '[H]unk [R]eset' })
    vim.keymap.set('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { buffer = buffer_number, desc = '[H]unk [R]eset selection' })
  end,
})
