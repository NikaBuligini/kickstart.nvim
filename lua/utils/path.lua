local M = {}

function M.get_project_name()
  local cwd = vim.fn.getcwd()

  cwd = cwd:gsub('/$', '') -- Remove trailing slash, if present

  local lastSegment = cwd:match '([^/]+)$'
  if lastSegment == nil then
    lastSegment = '.' -- Current directory for paths without '/'
  end

  return lastSegment
end

return M
