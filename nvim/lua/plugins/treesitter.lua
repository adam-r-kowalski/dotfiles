return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
      ensure_installed = { "lua", "rust", "wgsl" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      indent = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    }
  end
}
