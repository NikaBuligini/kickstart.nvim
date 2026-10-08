return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>f',
      function() require('conform').format { async = true } end,
      mode = { 'n', 'x' },
      desc = 'Format buffer or selection',
    },
    {
      '<leader>uf',
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.notify('Buffer format on save: ' .. (vim.b.disable_autoformat and 'off' or 'on'))
      end,
      desc = 'Toggle buffer format on save',
    },
  },
  opts = {
    default_format_opts = { lsp_format = 'never' },
    format_on_save = function(bufnr)
      if vim.b[bufnr].disable_autoformat or vim.bo[bufnr].buftype ~= '' then return end
      return { timeout_ms = 1000, lsp_format = 'never' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'oxfmt' },
      javascriptreact = { 'oxfmt' },
      typescript = { 'oxfmt' },
      typescriptreact = { 'oxfmt' },
      json = { 'oxfmt' },
      jsonc = { 'oxfmt' },
      json5 = { 'oxfmt' },
      markdown = { 'oxfmt' },
      yaml = { 'oxfmt' },
      toml = { 'oxfmt' },
      html = { 'oxfmt' },
      css = { 'oxfmt' },
      scss = { 'oxfmt' },
      less = { 'oxfmt' },
      graphql = { 'oxfmt' },
      vue = { 'oxfmt' },
      svelte = { 'oxfmt' },
      handlebars = { 'oxfmt' },
    },
  },
}
