local group = vim.api.nvim_create_augroup('config-autocmds', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = group,
  desc = 'Highlight yanked text',
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd('DirChanged', {
  group = group,
  desc = 'Update project title',
  callback = function() vim.o.titlestring = 'nvim: ' .. require('utils.path').get_project_name() end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = group,
  callback = function(event)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    if vim.bo[event.buf].filetype == 'lazygit' then vim.bo[event.buf].bufhidden = 'wipe' end
    vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:bdelete!<CR>', { buffer = event.buf, silent = true })
  end,
})
