return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  init = function()
    local group = vim.api.nvim_create_augroup('config-session-restore', { clear = true })
    local stdin = false
    vim.api.nvim_create_autocmd('StdinReadPre', {
      group = group,
      callback = function() stdin = true end,
    })
    vim.api.nvim_create_autocmd('VimEnter', {
      group = group,
      nested = true,
      once = true,
      callback = function()
        if stdin or vim.fn.argc() > 0 or vim.o.diff or #vim.api.nvim_list_uis() == 0 then return end
        require('persistence').load()
      end,
    })
  end,
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/',
    need = 1,
  },
  keys = {
    {
      '<leader>ws',
      function() require('persistence').load() end,
      desc = 'Restore Session',
    },
    {
      '<leader>ww',
      function() require('persistence').save() end,
      desc = 'Save Session',
    },
    {
      '<leader>wS',
      function() require('persistence').select() end,
      desc = 'Select Session',
    },
    {
      '<leader>wl',
      function() require('persistence').load { last = true } end,
      desc = 'Restore Last Session',
    },
    {
      '<leader>wd',
      function()
        local persistence = require 'persistence'

        local dir = require('persistence.config').options.dir
        local session_files = persistence.list()

        vim.ui.select(session_files, {
          prompt = 'Delete session',
          format_item = function(path) return path:sub(#dir + 1):gsub('%%', '/') end,
        }, function(choice)
          if choice == persistence.current() then persistence.stop() end

          if choice then
            vim.fn.delete(choice)
            vim.notify('Deleted session: ' .. choice)
          end
        end)
      end,
      desc = 'Delete Session',
    },
    {
      '<leader>wD',
      function() require('persistence').stop() end,
      desc = "Don't Save Current Session",
    },
  },
}
