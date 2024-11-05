local M = {}

function M.is_deno_project()
  local cwd = vim.fn.getcwd()
  return vim.loop.fs_stat(cwd .. '/deno.json') or vim.loop.fs_stat(cwd .. '/deno.jsonc')
end

return M
