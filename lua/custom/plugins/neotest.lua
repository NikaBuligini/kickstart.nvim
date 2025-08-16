return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'marilari88/neotest-vitest',
    'thenbe/neotest-playwright',
  },
  config = function()
    local neotest = require 'neotest'

    neotest.setup {
      adapters = {
        require 'neotest-vitest',

        require('neotest-playwright').adapter {
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
            debug = true,
          },
        },
      },
    }

    local wk = require 'which-key'

    wk.add {
      { mode = 'n', '<leader>t', group = 'Tests' },
      {
        mode = 'n',
        '<leader>tt',
        function()
          neotest.run.run()
        end,
        desc = 'Run nearest test',
      },
      {
        mode = 'n',
        '<leader>tT',
        function()
          neotest.run.run { suite = true }
        end,
        desc = 'Run test suite',
      },
      {
        mode = 'n',
        '<leader>td',
        function()
          neotest.run.run { strategy = 'dap', suite = false }
        end,
        desc = 'Debug nearest test',
      },
      {
        mode = 'n',
        '<leader>tf',
        function()
          neotest.run.run(vim.fn.expand '%')
        end,
        desc = 'Run tests in current file',
      },
      {
        mode = 'n',
        '<leader>tl',
        function()
          neotest.run.run_last()
        end,
        desc = 'Run last test',
      },
      {
        mode = 'n',
        '<leader>tS',
        function()
          neotest.run.stop()
        end,
        desc = 'Stop running tests',
      },
      {
        mode = 'n',
        '<leader>to',
        function()
          neotest.output.open { enter = true }
        end,
        desc = 'Open output window',
      },
      {
        mode = 'n',
        '<leader>ts',
        function()
          neotest.summary.toggle()
        end,
        desc = 'Toggle summary panel',
      },
      {
        mode = 'n',
        '<leader>tp',
        function()
          neotest.output_panel.toggle()
        end,
        desc = 'Toggle test output panel',
      },
      {
        mode = 'n',
        '[t',
        function()
          neotest.jump.prev { status = 'failed' }
        end,
        desc = 'Jump to previous failed test',
      },
      {
        mode = 'n',
        ']t',
        function()
          neotest.jump.next { status = 'failed' }
        end,
        desc = 'Jump to next failed test',
      },
    }
  end,
}
