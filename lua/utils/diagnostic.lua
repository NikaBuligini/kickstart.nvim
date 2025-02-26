local M = {}

function M.set_loclist_with_metadata()
  if vim.bo.buftype == 'quickfix' then
    -- Close the location list if it's already open
    vim.cmd 'lclose'
    return
  end

  local winnr = 0 -- Use the current window
  local diagnostics = vim.diagnostic.get(winnr) -- Get diagnostics for current buffer

  local items = {}
  for _, d in ipairs(diagnostics) do
    table.insert(items, {
      bufnr = d.bufnr,
      lnum = d.lnum + 1, -- Convert from 0-based to 1-based indexing
      col = d.col + 1, -- Convert from 0-based to 1-based
      text = string.format('[%s] %s (%s)', d.source or 'Unknown', d.message, d.code), -- Include source and code
      type = d.severity == vim.diagnostic.severity.ERROR and 'E'
        or d.severity == vim.diagnostic.severity.WARN and 'W'
        or d.severity == vim.diagnostic.severity.INFO and 'I'
        or 'H', -- H = Hint
    })
  end

  vim.fn.setloclist(winnr, items, 'r') -- Replace location list
  vim.cmd 'lopen' -- Open the location list
end

return M
