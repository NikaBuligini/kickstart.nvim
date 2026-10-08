return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    { 'leoluz/nvim-dap-go', cond = function() return vim.fn.executable 'go' == 1 end },
  },
  keys = {
    { '<F5>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint' },
    { '<F7>', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local adapters = { 'js' }
    if vim.fn.executable 'go' == 1 then table.insert(adapters, 'delve') end
    require('mason-nvim-dap').setup {
      automatic_installation = false,
      ensure_installed = adapters,
      -- Both adapters are configured below.
      handlers = { function() end },
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }
    local function signs()
      vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e06c75' })
      vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
      local icons = vim.g.have_nerd_font and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
        or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
      for name, icon in pairs(icons) do
        local hl = name == 'Stopped' and 'DapStop' or 'DapBreak'
        vim.fn.sign_define('Dap' .. name, { text = icon, texthl = hl, numhl = hl })
      end
    end
    signs()
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('config-dap', { clear = true }),
      callback = signs,
    })
    dap.listeners.after.event_initialized.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    if vim.fn.executable 'go' == 1 then require('dap-go').setup { delve = { detached = vim.fn.has 'win32' == 0 } } end

    dap.adapters['pwa-node'] = {
      type = 'server',
      host = '127.0.0.1',
      port = '${port}',
      executable = { command = 'js-debug-adapter', args = { '${port}', '127.0.0.1' } },
    }
    dap.adapters.node = dap.adapters['pwa-node']
    local filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }
    -- nvim-dap reads .vscode/launch.json dynamically when starting a session.
    require('dap.ext.vscode').type_to_filetypes['pwa-node'] = filetypes
    require('dap.ext.vscode').type_to_filetypes.node = filetypes

    for _, ft in ipairs(filetypes) do
      dap.configurations[ft] = {
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to Node process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to Node inspector (9229)',
          port = 9229,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
        },
      }
    end
    table.insert(dap.configurations.javascript, {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch current JavaScript file',
      program = '${file}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**' },
    })
  end,
}
