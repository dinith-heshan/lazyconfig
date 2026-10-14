vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('plugins-pack-changed', { clear = true }),
  callback = function(args)
    local name, kind = args.data.spec.name, args.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'nvim-treesitter' then
      if not args.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end

    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = args.data.path }):wait()
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },

  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },

  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/tpope/vim-fugitive' },
})

require('plugins.tokyonight')
require('plugins.lualine')

require('plugins.oil')
require('plugins.telescope')

require('plugins.treesitter')

require('plugins.mini')
require('plugins.gitsigns')
require('plugins.fugitive')
