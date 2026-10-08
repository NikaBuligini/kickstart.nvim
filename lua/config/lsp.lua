local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup('config-lsp', { clear = true })
  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    callback = function(event)
      local function map(keys, callback, desc, mode) vim.keymap.set(mode or 'n', keys, callback, { buffer = event.buf, desc = 'LSP: ' .. desc }) end
      local function picker(name)
        return function() require('telescope.builtin')[name]() end
      end

      map('grn', vim.lsp.buf.rename, 'Rename')
      map('gra', vim.lsp.buf.code_action, 'Code action', { 'n', 'x' })
      map('grD', vim.lsp.buf.declaration, 'Declaration')
      map('grr', picker 'lsp_references', 'References')
      map('gri', picker 'lsp_implementations', 'Implementation')
      map('grd', picker 'lsp_definitions', 'Definition')
      map('grt', picker 'lsp_type_definitions', 'Type definition')
      map('gO', picker 'lsp_document_symbols', 'Document symbols')
      map('gW', picker 'lsp_dynamic_workspace_symbols', 'Workspace symbols')

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client then return end

      if client:supports_method('textDocument/inlayHint', event.buf) then
        map(
          '<leader>uh',
          function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }, { bufnr = event.buf }) end,
          'Toggle inlay hints'
        )
      end

      if client.name == 'vtsls' then
        local commands = require('vtsls').commands
        map('grs', function() commands.goto_source_definition(0) end, 'Source definition')
        map('<leader>co', function() commands.organize_imports(event.buf) end, 'Organize imports')
        map('<leader>cm', function() commands.add_missing_imports(event.buf) end, 'Add missing imports')
        map('<leader>cr', function() commands.rename_file(event.buf) end, 'Rename file and update imports')
        map('<leader>cv', function() commands.select_ts_version(event.buf) end, 'Select TypeScript version')
      elseif client.name == 'oxlint' then
        map('<leader>cF', '<cmd>LspOxlintFixAll<CR>', 'Apply Oxlint fixes')
      end

      if client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlights = vim.api.nvim_create_augroup('config-lsp-highlight-' .. event.buf, { clear = true })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          group = highlights,
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          group = highlights,
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })

  vim.api.nvim_create_autocmd('LspDetach', {
    group = group,
    callback = function(event)
      for _, client in ipairs(vim.lsp.get_clients { bufnr = event.buf }) do
        if client.id ~= event.data.client_id and client:supports_method('textDocument/documentHighlight', event.buf) then return end
      end
      vim.api.nvim_buf_call(event.buf, vim.lsp.buf.clear_references)
      pcall(vim.api.nvim_del_augroup_by_name, 'config-lsp-highlight-' .. event.buf)
    end,
  })
end

return M
