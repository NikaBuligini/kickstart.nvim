vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = false,
  virtual_lines = { current_line = true },
  jump = {
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then return end
      vim.diagnostic.open_float(bufnr, { scope = 'cursor', focus = false, border = 'rounded', source = 'if_many' })
    end,
  },
}

vim.keymap.set('n', '<leader>ud', function()
  local expanded = not not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config {
    virtual_text = expanded,
    virtual_lines = not expanded and { current_line = true } or false,
  }
end, { desc = 'Toggle diagnostic detail' })
