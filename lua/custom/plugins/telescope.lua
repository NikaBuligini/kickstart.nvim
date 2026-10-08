return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable 'make' == 1 end },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'

    telescope.setup {
      pickers = { find_files = { hidden = true } },
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
        file_browser = { theme = 'ivy', previewer = false, hijack_netrw = true },
      },
    }
    pcall(telescope.load_extension, 'fzf')
    telescope.load_extension 'ui-select'
    telescope.load_extension 'file_browser'

    local function selection()
      local text = vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', { type = vim.fn.mode() })
      return table.concat(text, '\n')
    end

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sb', telescope.extensions.file_browser.file_browser, { desc = '[B]rowse files' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
    vim.keymap.set(
      'x',
      '<leader>sw',
      function() builtin.current_buffer_fuzzy_find { default_text = selection() } end,
      { desc = 'Search selection in current file' }
    )
    vim.keymap.set('x', '<leader>sg', function() builtin.grep_string { search = selection() } end, { desc = 'Grep selection' })
    vim.keymap.set(
      'n',
      '<leader>/',
      function() builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false }) end,
      { desc = 'Fuzzily search in current buffer' }
    )
    vim.keymap.set(
      'n',
      '<leader>s/',
      function() builtin.live_grep { grep_open_files = true, prompt_title = 'Live Grep in Open Files' } end,
      { desc = 'Search in open files' }
    )
    vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Search Neovim files' })
  end,
}
