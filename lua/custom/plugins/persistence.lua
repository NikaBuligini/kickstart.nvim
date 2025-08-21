vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('persistence', { clear = true }),
  callback = function()
    require('persistence').load()
  end,
  nested = true,
})

return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/',
    need = 0,
  },
  keys = {
    {
      '<leader>ws',
      function()
        require('persistence').load()
      end,
      desc = 'Restore Session',
    },
    {
      '<leader>ww',
      function()
        require('persistence').save()
      end,
      desc = 'Save Session',
    },
    {
      '<leader>wS',
      function()
        require('persistence').select()
      end,
      desc = 'Select Session',
    },
    {
      '<leader>wl',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restore Last Session',
    },
    {
      '<leader>wd',
      function()
        require('persistence').stop()
      end,
      desc = "Don't Save Current Session",
    },
    {
      '<leader>wD',
      function()
        local persistence = require 'persistence'

        local dir = vim.fn.stdpath 'state' .. '/sessions/'

        vim.ui.select(vim.fn.globpath(dir, '*', 0, 1), {
          prompt = 'Delete session',
        }, function(choice)
          if choice == persistence.current() then
            persistence.stop()
          end

          if choice then
            vim.fn.delete(choice)
            vim.notify('Deleted session: ' .. choice)
          end
        end)
      end,
      desc = 'Delete Session',
    },
  },
}
