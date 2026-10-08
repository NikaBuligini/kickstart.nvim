return {
  { 'NMAC427/guess-indent.nvim', opts = {} },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
  {
    'nvim-mini/mini.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      local ai = require 'mini.ai'
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
          a = ai.gen_spec.treesitter { a = '@parameter.outer', i = '@parameter.inner' },
        },
      }
      require('mini.icons').setup()
      require('mini.surround').setup()
      require('mini.splitjoin').setup()
      -- Keep gr available for LSP actions; use gR for the replace operator.
      require('mini.operators').setup { replace = { prefix = 'gR' } }
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar', 'GrugFarWithin' },
    opts = {},
    keys = {
      { '<leader>sR', '<cmd>GrugFar<CR>', mode = 'n', desc = 'Search and replace' },
      { '<leader>sR', ':GrugFar<CR>', mode = 'x', desc = 'Search and replace selection' },
    },
  },
  {
    'stevearc/quicker.nvim',
    ft = 'qf',
    opts = {
      keys = {
        { '>', function() require('quicker').expand { before = 2, after = 2, add_to_existing = true } end, desc = 'Expand result context' },
        { '<', function() require('quicker').collapse() end, desc = 'Collapse result context' },
      },
    },
  },
}
