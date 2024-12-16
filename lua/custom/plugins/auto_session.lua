return {
  'rmagatti/auto-session',
  lazy = false,

  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<leader>wf', '<cmd>SessionSearch<CR>', desc = '[F]ind session' },
    { '<leader>ww', '<cmd>SessionSave<CR>', desc = '[W]rite session' },
    { '<leader>wd', '<cmd>SessionDelete<CR>', desc = '[D]elete session' },
    { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle [a]utosave' },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- log_level = 'debug',
  },
}
