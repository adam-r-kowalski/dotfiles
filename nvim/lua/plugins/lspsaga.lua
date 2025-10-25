return {
  'nvimdev/lspsaga.nvim',
  event = "LspAttach",
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    diagnostic = {
      show_source = true,
    },
  },
  keys = {
    { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
    { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev Diagnostic" },
    { "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Cursor Diagnostic" },
    { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Documentation" },
    { "gh", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Documentation" },
    { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to definition" },
    { "gr", "<cmd>Lspsaga finder<cr>", desc = "Go to references" },
  },
}
