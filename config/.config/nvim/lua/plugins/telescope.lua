local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local toggle_hidden_key = '<C-a>'

telescope.setup({
  defaults = {
    path_display = { 'truncate' },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

local function open_picker(picker, title, extra_opts, show_hidden, default_text)
  local opts = vim.tbl_extend('force', extra_opts, {
    default_text = default_text,
    prompt_title = show_hidden and (title .. ' + hidden') or title,
    attach_mappings = function(_, map)
      map({ 'i', 'n' }, toggle_hidden_key, function(prompt_bufnr)
        local text = action_state.get_current_line()
        actions.close(prompt_bufnr)
        open_picker(picker, title, extra_opts, not show_hidden, text)
      end)
      return true
    end,
  })
  if picker == builtin.find_files then
    opts.hidden = show_hidden
    opts.file_ignore_patterns = { '^%.git/' }
  elseif show_hidden then
    opts.additional_args = { '--hidden', '--glob=!**/.git/*' }
  end
  picker(opts)
end

local function with_hidden_toggle(picker, title)
  return function()
    local picker_title, extra_opts = title, {}
    if picker == builtin.grep_string then
      local word = vim.fn.expand('<cword>')
      picker_title = title .. ' (' .. word .. ')'
      extra_opts.search = word
    end
    open_picker(picker, picker_title, extra_opts, false)
  end
end

vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Buffers' })

vim.keymap.set('n', '<leader>ff', with_hidden_toggle(builtin.find_files, 'Find Files'), { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fw', with_hidden_toggle(builtin.grep_string, 'Find Word'), { desc = '[F]ind [W]ord under cursor' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>lg', with_hidden_toggle(builtin.live_grep, 'Live Grep'), { desc = '[L]ive [G]rep' })
