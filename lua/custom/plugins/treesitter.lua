return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
      local parsers = {
        'bash',
        'css',
        'diff',
        'go',
        'hcl',
        'html',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'rust',
        'terraform',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      }
      local group = vim.api.nvim_create_augroup('config-treesitter', { clear = true })
      local function install_parsers()
        if vim.fn.executable 'tree-sitter' == 1 then require('nvim-treesitter').install(parsers) end
      end
      install_parsers()
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'MasonToolsUpdateCompleted',
        callback = install_parsers,
      })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        callback = function(event)
          local language = vim.treesitter.language.get_lang(event.match)
          if not language then return end
          local ok, parser = pcall(vim.treesitter.language.add, language)
          if not ok or not parser then return end
          vim.treesitter.start(event.buf, language)
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
      -- Folds are window-local, so configure them whenever a buffer enters a window.
      vim.api.nvim_create_autocmd({ 'BufWinEnter', 'FileType' }, {
        group = group,
        callback = function(event)
          if vim.bo[event.buf].buftype ~= '' then return end
          local ok, parser = pcall(vim.treesitter.get_parser, event.buf)
          vim.wo.foldmethod = ok and parser and 'expr' or 'manual'
          vim.wo.foldexpr = ok and parser and 'v:lua.vim.treesitter.foldexpr()' or '0'
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { move = { set_jumps = true } },
    config = function(_, opts)
      require('nvim-treesitter-textobjects').setup(opts)
      local move = require 'nvim-treesitter-textobjects.move'
      for key, method in pairs {
        [']m'] = 'goto_next_start',
        ['[m'] = 'goto_previous_start',
        [']M'] = 'goto_next_end',
        ['[M'] = 'goto_previous_end',
      } do
        vim.keymap.set({ 'n', 'x', 'o' }, key, function() move[method]('@function.outer', 'textobjects') end, { desc = 'Function: ' .. method })
      end
      vim.keymap.set(
        'n',
        '<leader>ca',
        function() require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner' end,
        { desc = 'Swap with next parameter' }
      )
      vim.keymap.set(
        'n',
        '<leader>cA',
        function() require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.inner' end,
        { desc = 'Swap with previous parameter' }
      )
    end,
  },
}
