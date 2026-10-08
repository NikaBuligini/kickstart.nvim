return {
  'dmtrKovalenko/fff.nvim',
  build = function() require('fff.download').download_or_build_binary() end,
  lazy = false,
  opts = { debug = { enabled = false, show_scores = false } },
  keys = {
    { '<leader>pf', function() require('fff').find_files() end, desc = 'FFF files' },
    { '<leader>pg', function() require('fff').live_grep() end, desc = 'FFF live grep' },
    {
      '<leader>pz',
      function() require('fff').live_grep { grep = { modes = { 'fuzzy', 'plain' } } } end,
      desc = 'FFF fuzzy grep',
    },
    { '<leader>pw', function() require('fff').live_grep { query = vim.fn.expand '<cword>' } end, desc = 'FFF current word' },
  },
}
