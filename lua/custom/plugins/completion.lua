return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  dependencies = {
    'nvim-mini/mini.nvim',
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = vim.fn.has 'win32' == 0 and vim.fn.executable 'make' == 1 and 'make install_jsregexp' or nil,
      config = function()
        require('luasnip').setup {}
        require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }
        require('luasnip').filetype_extend('typescriptreact', { 'typescript' })
        require('luasnip').filetype_extend('javascript', { 'typescript' })
        require('luasnip').filetype_extend('javascriptreact', { 'typescript' })
      end,
    },
  },
  opts = {
    keymap = { preset = 'enter' },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local icon = require('mini.icons').get('lsp', ctx.kind)
                return icon
              end,
              highlight = function(ctx)
                local _, hl = require('mini.icons').get('lsp', ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets' },
      providers = { lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 } },
    },
    snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
  },
}
