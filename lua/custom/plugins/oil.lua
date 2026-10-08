return {
  'stevearc/oil.nvim',
  opts = {
    -- Telescope File Browser owns directory buffers; Oil is opened explicitly with -.
    default_file_explorer = false,
    keymaps = {
      gs = {
        callback = function() require('grug-far').open { prefills = { paths = require('oil').get_current_dir() } } end,
        desc = 'Search and replace in directory',
      },
    },
  },
  dependencies = { 'nvim-mini/mini.nvim' },
  lazy = false,

  config = function(_, opts)
    require('oil').setup(opts)

    vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })
  end,
}
