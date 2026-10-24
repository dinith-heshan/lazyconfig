local function is_editing_window()
  if vim.api.nvim_win_get_config(0).relative ~= '' then
    return false
  end
  local bt = vim.bo.buftype
  return bt ~= 'prompt' and bt ~= 'nofile'
end

require('lualine').setup({
  options = {
    theme = 'auto',
    globalstatus = true,
    icons_enabled = true,
    section_separators = { left = '\u{e0b0}', right = '\u{e0b2}' },
    component_separators = { left = '|', right = '|' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { { 'filename', path = 1, cond = is_editing_window } },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})
