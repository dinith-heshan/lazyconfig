local parsers = {
  'bash',
  'c',
  'diff',
  'dockerfile',
  'gitcommit',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'sql',
  'toml',
  'typescript',
  'vim',
  'vimdoc',
  'yaml'
}

require('nvim-treesitter').install(parsers)

local available = require('nvim-treesitter').get_available()
local warned = {}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('plugins-treesitter', { clear = true }),
  desc = 'Start treesitter highlighting and indent, warn if the parser is missing',
  callback = function(args)
    local language = vim.treesitter.language.get_lang(args.match)
    if not language then return end

    if vim.treesitter.language.add(language) then
      vim.treesitter.start(args.buf, language)
      if vim.treesitter.query.get(language, 'indents') ~= nil then
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    elseif vim.tbl_contains(available, language) and not warned[language] then
      warned[language] = true
      vim.notify(
        ("No treesitter parser for '%s'. Add it to plugins/treesitter.lua"):format(language),
        vim.log.levels.WARN
      )
    end
  end,
})
