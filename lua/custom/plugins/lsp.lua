return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
    { 'folke/lazydev.nvim', ft = 'lua', opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } } },
    { 'yioneko/nvim-vtsls', config = function() require('vtsls').config {} end },
  },
  config = function()
    require('config.lsp').setup()

    local servers = {
      vtsls = {
        settings = {
          vtsls = { autoUseWorkspaceTsdk = true },
          typescript = {
            format = { enable = false },
            updateImportsOnFileMove = { enabled = 'always' },
            inlayHints = { parameterNames = { enabled = 'literals' }, functionLikeReturnTypes = { enabled = true } },
          },
          javascript = {
            format = { enable = false },
            updateImportsOnFileMove = { enabled = 'always' },
            inlayHints = { parameterNames = { enabled = 'literals' }, functionLikeReturnTypes = { enabled = true } },
          },
        },
      },
      lua_ls = { settings = { Lua = { format = { enable = false } } } },
      jsonls = {
        settings = {
          json = {
            format = { enable = false },
            schemas = {
              { fileMatch = { 'package.json' }, url = 'https://json.schemastore.org/package.json' },
              { fileMatch = { 'tsconfig*.json' }, url = 'https://json.schemastore.org/tsconfig.json' },
              { fileMatch = { '.stylelintrc', '.stylelintrc.json', 'stylelint.config.json' }, url = 'https://json.schemastore.org/stylelintrc.json' },
              {
                fileMatch = { 'lefthook*.json', '.lefthook*.json' },
                url = 'https://raw.githubusercontent.com/evilmartians/lefthook/refs/heads/master/schema.json',
              },
              { fileMatch = { 'nx.json', 'nx.jsonc' }, url = 'https://raw.githubusercontent.com/nrwl/nx/refs/heads/master/packages/nx/schemas/nx-schema.json' },
            },
          },
        },
      },
      yamlls = {
        settings = { yaml = { format = { enable = false }, schemas = { ['https://json.schemastore.org/pnpm-workspace.json'] = 'pnpm-workspace.yaml' } } },
      },
      tailwindcss = {
        filetypes = vim.tbl_filter(function(ft) return ft ~= 'markdown' end, vim.lsp.config.tailwindcss.filetypes),
      },
      terraformls = {},
      rust_analyzer = {},
      oxlint = { settings = { typeAware = true } },
    }

    -- Only explicitly configured servers are enabled, including on machines with older tools installed.
    require('mason-lspconfig').setup { automatic_enable = false }
    local tools = { 'stylua', 'oxfmt', 'tree-sitter-cli' }
    local ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools)
    table.sort(ensure_installed)
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    for name, server in pairs(servers) do
      vim.lsp.config(name, server)
      vim.lsp.enable(name)
    end
  end,
}
