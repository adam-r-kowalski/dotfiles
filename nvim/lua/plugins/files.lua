vim.pack.add({'https://github.com/nvim-mini/mini.files.git'})
local minifiles = require('mini.files')
minifiles.setup({
  mappings = {
    close       = 'q',
    go_in       = 'L',
    go_in_plus  = 'l',
    go_out      = 'h',
    go_out_plus = 'H',
    mark_goto   = "'",
    mark_set    = 'm',
    reset       = '<BS>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = '=',
    trim_left   = '<',
    trim_right  = '>',
  },
})
vim.keymap.set('n', '-', minifiles.open)
