vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

local diagnosticUtils = require 'utils.diagnostic'
vim.keymap.set('n', '<leader>q', diagnosticUtils.set_loclist_with_metadata, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll window downwards and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll window upwards and center' })

-- Telescope results can be sent to quickfix with <C-q>.
vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>', { desc = 'Go to the next quickfix item' })
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>', { desc = 'Go to the previous quickfix item' })
vim.keymap.set('n', ']l', '<cmd>lnext<CR>', { desc = 'Next location-list item' })
vim.keymap.set('n', '[l', '<cmd>lprev<CR>', { desc = 'Previous location-list item' })

vim.keymap.set('n', '<leader>x', ':.lua<CR>', { desc = 'Execute Lua code' })
vim.keymap.set('v', '<leader>x', ':lua<CR>', { desc = 'Execute Lua code for visually selected' })
vim.keymap.set('n', '<leader>cb', '<cmd>%bd|e#<CR>', { desc = '[C]lear All [B]uffers but current' })
vim.keymap.set('n', '<leader>rl', '<cmd>lsp restart<CR>', { desc = '[R]estart [L]sp' })

vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.cmd.startinsert()
  vim.api.nvim_win_set_height(0, 15)
end, { desc = '[S]mall [T]erminal' })
