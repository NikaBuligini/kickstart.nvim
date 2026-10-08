return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = 'Search', mode = { 'n', 'x' } },
        { '<leader>p', group = 'FFF pickers' },
        { '<leader>u', group = 'Toggles' },
        { '<leader>t', group = 'Tests' },
        { '<leader>h', group = 'Git hunks', mode = { 'n', 'x' } },
        { '<leader>l', group = 'LazyGit' },
        { '<leader>c', group = 'Code' },
        { '<leader>w', group = 'Sessions' },
        { 'gr', group = 'LSP actions' },
      },
    },
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        styles = { comments = { italic = false } },
        on_highlights = function(hl, c)
          hl.htmlTagName = { fg = c.blue }
          hl.tsxTagName = { fg = c.yellow }
          hl.typescriptVariableDeclaration = { fg = c.yellow }
        end,
      }
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
